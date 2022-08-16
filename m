Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA71859563D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiHPJ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiHPJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:28:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4C984EC1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:47:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a9so13680342lfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=bfjb0/RfkSEH8cB4ALMY2SGVoeLIuba0qPdHr8FxVDM=;
        b=JergNskWN39xPnLR5bvGb/rCaV2bCBGy6Rr6807+zCmwbPATiofxQXz31ejofM+fTn
         /LSroNpUiD8E04wD1HxsOHKUwNGVROS6TugMtPbciWn0guFvovnPChmir67JJnL5kApM
         EGLksAAooPXuouSUkIiEdtVcN5frHTAexLurasHzVDazNhBDwIje+pJlI7upfUOqmNs+
         2Ub+ditZVqe2TJuko2iQJzGAtrNIUN8VHjUWNkG4T8Bxa6Y0YucXPTLYA+pDZVjpkMlN
         /VknpL5iz198nETtdRlkgdBFzv3RpDgHQidhkVtMhs7NCpwZpD3ioUdGQCHmeyeMEMha
         ti4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=bfjb0/RfkSEH8cB4ALMY2SGVoeLIuba0qPdHr8FxVDM=;
        b=HeXyJyq7UfpJfMI/PQ1YrhfI8Ur+kRFrg0UQSvQQYGXXHnVZ1/EY8JoyQzMKwmLvMx
         nH9ACSpkGcaiR9HeCdxXO3sWvO1ERTArLK4b/Tlb6sf4wHlOcr6jra44/puaFj2iAgqW
         WQoi2/5dBtOj/V4Ac0XW4ihpROpqa3NKi4HMHJDtxWaERsZG2bECOZCFm0Q8CmYErVj3
         NeOboecL2up3AVAxz939BrG/oz94v9vfGHO59lFqyZliSTSO/bdLmvxt2aeVOgTMLCOR
         ISSJKDJcJ6eD2CXSkB9GvoD6Lq7l9s4w91e7XOmEtyhsrHCuwK4zis2yB96DdcTX/UE7
         FDaw==
X-Gm-Message-State: ACgBeo02I7tlzCr1VuiMHzGx6p+y5xk+JK53prd2vEv1dGJkrlNvy1Pp
        hIgC/yP8lZEkZ8kM8luszZRoN9SZJB9fPw==
X-Google-Smtp-Source: AA6agR5vf4p7y8ytFz18vjFkux0n2aXgqMRzh8CVptkCH6zQ+cQScbcS6mdiOHeYVNFjDSCINFcJaA==
X-Received: by 2002:a05:6512:158b:b0:48b:38:cff8 with SMTP id bp11-20020a056512158b00b0048b0038cff8mr6268892lfb.100.1660636026941;
        Tue, 16 Aug 2022 00:47:06 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0048b1f89ce24sm1301726lfr.264.2022.08.16.00.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:47:06 -0700 (PDT)
Message-ID: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
Date:   Tue, 16 Aug 2022 10:47:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Vasily Averin <vvs@openvz.org>
Subject: Re: [PATCH 0/3] enable memcg accounting for kernfs objects
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <0414cab3-32d6-c60a-d3c8-96fc72064ba0@openvz.org>
 <YvKZ8zYJFhhFvRxO@slm.duckdns.org> <20220809174934.GC10478@blackbody.suse.cz>
 <YvKfxGvg5/J0+QoD@slm.duckdns.org>
 <b816f58a-ce25-c079-c6b3-a3406df246f9@openvz.org>
In-Reply-To: <b816f58a-ce25-c079-c6b3-a3406df246f9@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 06:19, Vasily Averin wrote:
> On 8/9/22 20:56, Tejun Heo wrote:
>> Hello,
>>
>> On Tue, Aug 09, 2022 at 07:49:34PM +0200, Michal Koutný wrote:
>>> On Tue, Aug 09, 2022 at 07:31:31AM -1000, Tejun Heo <tj@kernel.org> wrote:
>>>> I'm not quite sure whether following the usual "charge it to the allocating
>>>> task's cgroup" is the best way to go about it. I wonder whether it'd be
>>>> better to attach it to the new cgroup's nearest ancestor with memcg enabled.
>>>
>>> See also 
>>> https://lore.kernel.org/r/YnBLge4ZQNbbxufc@blackbook/
>>> and
>>> https://lore.kernel.org/r/20220511163439.GD24172@blackbody.suse.cz/
>>
>> Ah, thanks. Vasily, can you please include some summary of the discussions
>> and the rationales for the path taken in the commit message?
> 
> Dear Tejun,
> thank you for the feedback, I'll do it in next patch set iteration.
> 
> However, I noticed another problem in neighborhood and I planned to
> add new patches into current patch set. One of the new patches is quite simple,
> however second one is quite complex and requires some discussion.

Summing up a private discussion with Tejun, Michal and Roman:
I'm going to create few new patches:

1) adjust active memcg for objects allocated during creation of new cgroup
  This patch will take memcg from parent cgroup an use it for accounting
  all objects allocated during creation of new cgroup.
  For that it moves set_active_memcg() calls from mem_cgroup_css_alloc()
  to cgroup_mkdir() and creates missing infrastructure.
  This allows you to predict which memcg should be used for object accounting,
  and should simplify debugging of possible problems and corner cases.

2) memcg: enable kernfs accounting: nodes and iattr
  Already discussed and approved patches.
  These objects consumes significant part of memory in various scenarios,
  including new cgroup creation and new net device creation.

3) adjust active memcg for simple_xattr accounting
  sysfs and tmpfs are in-memory file system, 
  for extended attributes they uses simple_xattr infrastructure.
  The patch forces sys_set[f]xattr calls to account xattr object
  to predictable memcg: for kernfs memcg will be taken from kernfs node,
  for shmem -- from shmem_info.
  Like 1) case, this allows to understand which memcg should be used
  for object accounting and simplify debugging of possible troubles.

4) memcg: enable accounting for simple_xattr: names and values
  This patch enables accounting for objects described in previous patch

5) simple_xattrs: replace list to rb-tree
  This significantly reduces the search time for existing entries.

Additionally Roman Gushchin prepares patch
"`put`ting the kernfs_node reference earlier in the cgroup removal process"

Thank you,
	Vasily Averin
