Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E208575A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 06:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiGOEpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 00:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGOEpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 00:45:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B597A62A5B;
        Thu, 14 Jul 2022 21:45:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k19so2247994pll.5;
        Thu, 14 Jul 2022 21:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DRHClB5BYENwtyQXEZigOp1KZKAnPunxuF0IW+oQZJU=;
        b=mtlw8663BOcm7bg1VsTypZCWjyoLYRJZnO4+hMEzSdHzDLrvBc/Ibz/H8MOJpyNT1y
         KvAIznkyb2xwozj55gRtbXMGM6aDxoBKSuxIG9V+rpdq1szPCxpVMcKxzWmzD9Sfu27B
         Qdj9ZleIpjatWxy7oahzpNY30weOR+3lA8tR7MSxb5pGqfzIfSs5rTIn1NbHBWEojRpv
         V7yUPkHE1P0tXN6MyA3zvX0EsJs09lRuDr2xk/Av+MpG6eIq9erYrgHGL8jn51rzlNoX
         7rbI7Dp38RD1z9Mvgen76R0sfvSHbAuNLEOgOpvf47T4/eYwSUjfLzjhSVETWQM8p/x2
         4qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DRHClB5BYENwtyQXEZigOp1KZKAnPunxuF0IW+oQZJU=;
        b=sUtYjMcr/7tj1YMO/VrTFf9PoVTtE6DtloJ9vofasVwYLqT8vuqD/ml9OgXfkzUCyl
         rboWHWjf2fRbYb9Xt8BMX+soYWlhh7rlM2Gkc1ui76RsLkb+s/YmkRSof4F3ShVXAUNG
         /5VT3JHabYgR4+FiQdD08z/qLuclzekdnDOoW0mmZ42Tgo34S6H/R+IWb2ExH16GqI8T
         6JVBemVRDt2o2a3FJW9MD9pB5VbZNklaExKiI4kDkXEiU83GM/rFLJkR21lr/DERjS1B
         ZOsyy8MZ7nBQJgrTXH7t4PLhFuq3TzJMBnD+VlVEXj48KaT7k0/uAMwARkR5+dkQpJ1K
         i3AA==
X-Gm-Message-State: AJIora+n7WGuUFhLmMwJ8Lz3H5q45eWbDWjYywPCbrK4PHe8p+tPgx3W
        EmRxU3c70nfv+mZTgjWqhX8=
X-Google-Smtp-Source: AGRyM1un19bitLuSvnONqwpHaQgn9j4Oq7PbkbA674hEHebtfhCF8fIvz4cxcEquCjg5tKwzKZ03dw==
X-Received: by 2002:a17:90a:2b4a:b0:1ef:3e28:fbc8 with SMTP id y10-20020a17090a2b4a00b001ef3e28fbc8mr13304447pjc.54.1657860350117;
        Thu, 14 Jul 2022 21:45:50 -0700 (PDT)
Received: from [192.168.66.3] (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902d14400b0016bfcfde685sm2349734plt.56.2022.07.14.21.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 21:45:49 -0700 (PDT)
Message-ID: <2b73e71c-a927-076d-bf44-6dc4431eb3be@gmail.com>
Date:   Fri, 15 Jul 2022 13:45:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] AMD_SFH: Add a DMI quirk entry for Chromebooks
Content-Language: en-US
To:     Basavaraj Natikar <bnatikar@amd.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20220714053752.5124-1-akihiko.odaki@gmail.com>
 <87d96692-7dbf-f846-f644-5a81f92efcb9@amd.com>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <87d96692-7dbf-f846-f644-5a81f92efcb9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/07/15 13:41, Basavaraj Natikar wrote:
> 
> 
> On 7/14/2022 11:07 AM, Akihiko Odaki wrote:
>> Google Chromebooks use Chrome OS Embedded Controller Sensor Hub instead
>> of Sensor Hub Fusion and leaves MP2 uninitialized, which disables all
>> functionalities, even including the registers necessary for feature
>> detections.
>>
>> The behavior was observed with Lenovo ThinkPad C13 Yoga.
>>
>>
> This driver should not get loaded in chrome OS by default.
> Could you please provide details of Chrome OS Version and Kernel version to confirm the behavior.
> 
> Are you enabling manually CONFIG_AMD_SFH_HID config?
> 
> Thanks,
> Basavaraj
> 

I use Fedora 36, not Chrome OS. The config is enabled on Fedora's 
generic kernel. The kernel is built from commit 
78ca55889a549a9a194c6ec666836329b774ab6d from the upstream.

Regards,
Akihiko Odaki
