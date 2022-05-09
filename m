Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB17D51F8B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiEIJzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbiEIJsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:48:04 -0400
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BC725E95
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:44:04 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Kxbpn59SKzMpyc1;
        Mon,  9 May 2022 11:44:01 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Kxbpm2dG6zljsTk;
        Mon,  9 May 2022 11:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1652089441;
        bh=IFfFmj2+RkCP9G2Z76uXCcYYBbyAciGpIE19FbUTSso=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=IEGm/NO+iC7mfpMeM7kDDqb2BbcLTxaPn10tJd1KkeIhaOhQ0D/esgbepxz2l/IU7
         Qdm7dVb4MxbAm+acN9SEZk9SpKbJ6jkOoNO1aUBDiByt5HJPYFyT/zVOG/Jd+wqmnp
         lvaiGBEJQfL2IJW4dBcw7wm5F1fEKD74qlb7q/QQ=
Message-ID: <0be9b4c6-3e32-3d18-1715-aaadd6324701@digikod.net>
Date:   Mon, 9 May 2022 11:45:44 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <20220506160513.523257-1-mic@digikod.net>
 <CANiq72=SWen7sJxvQGD5N=ur-gpOiFGeHHfjegHxjaHfN_i95Q@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1 0/7] Landlock: Clean up coding style with clang-format
In-Reply-To: <CANiq72=SWen7sJxvQGD5N=ur-gpOiFGeHHfjegHxjaHfN_i95Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/05/2022 11:06, Miguel Ojeda wrote:
> Hi Mickaël,
> 
> (Answering in v1 since I want to quote something in this cover letter)

There is only a v1 for this specific series, but other series (with 
higher versions) are now relying on this one. ;)

> 
> On Fri, May 6, 2022 at 6:03 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> I used a simple coding style for the initial Landlock code.  However,
>> this may be subject to different interpretations.  To avoid relying
>> on tacit knowledge or text editors for these kind of rules, let's
>> automate it as much as possible thanks to clang-format.  This makes the
>> code formatting simple, consistent and impersonal.
> 
> Thanks for moving your subsystem to `clang-format`. I am glad you
> found it useful.
> 
>> Several versions of clang-format can be use but they may have (small)
>> different behaviors for undefined/new configuration parts.  After
>> testing different versions, I picked clang-format-14 which is relatively
>> new and fixes a bug present in version 11 to 13 (visible in the Landlock
>> formatted code).
> 
> Which was the bug?

You can check it by running clang-format-X on security/landlock/fs.c [1] 
and you'll get different results for this hunk (only):

--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -688,7 +688,7 @@ static inline access_mask_t maybe_remove(const 
struct dentry *const dentry)
  	if (d_is_negative(dentry))
  		return 0;
  	return d_is_dir(dentry) ? LANDLOCK_ACCESS_FS_REMOVE_DIR :
-				  LANDLOCK_ACCESS_FS_REMOVE_FILE;
+					LANDLOCK_ACCESS_FS_REMOVE_FILE;
  }

  /**


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=landlock-wip
