Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5857BE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiGTTA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiGTTAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:00:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42CC39B82
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:00:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r9so31786792lfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nXbqLZ52l8rkAxQgKq0ZUlGmE/J2GY5DjCY+3KWjA1Q=;
        b=CMOjU4rp5sj91z03o+3gaF3/LSL0widFjnesWZJSVXp3ZnrU+C0MhweYjvkEGOhBA9
         8lEFxJkmrbFlzPq/fyKQc4W1cglx2GyxhD/N3WhFuXNmDdXjLsOYLmhc/khwu7qUHswB
         MvQzEi13TzixX5rSpDi4F4xQeNONZrHkm9trYuad5fjGqbtgvytZxZrH16E8B2FU4w4E
         wtDgihrLQpA9rjnk2GIGaksTkQbb3s4wTN0rjUHzRublwOqDR1sLDRkvTS4iNGWVibeQ
         E8xApwywwSVS3nOcMB4Xo17TOtb72mnDlqJ6iWRhN+571if1ktnLMYmAnCPEwo+Xxm0o
         289g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nXbqLZ52l8rkAxQgKq0ZUlGmE/J2GY5DjCY+3KWjA1Q=;
        b=OyFdditxzp8dA5EdLxx+be4s5LB/6m80z6eVIeR5mXYCdkItbq+XxHZsR7SuY/DsYN
         dnJ+9PRi4XYDCH+OeylkmnubyuGNZ8re0OXsklZBPdmXvuw4fRARHbRCetqoRoh7usP4
         wIpczE4CTM6gfvYMhURgztcdb0/n5SdmbhsYdTf52z4zpaWRafOLHKAv75osUBEcc8Zu
         H0ucxFIrtcPhNeBjhBo0RI4oYWta6R6bKO2bjEvljr6D5FJLI8LatksqDOpRO6465XTj
         AvEGAv4H6fZsBKuo1ckEReUZ4oMPc3GkngOR1lk4FCySNH++l4WTYmQMFSxF0i9VRAlj
         HM5g==
X-Gm-Message-State: AJIora+cr5WQGtIDFMdTa6Ugn92y3Go4ZTRPTqUEM3jvgU3FGRLxI73M
        bbLX2LuXc3KYIpcFfm8QyYs=
X-Google-Smtp-Source: AGRyM1tj6l0S42zkoOEMR6ssrYGWstFB+ylRfRCkxaFpAaoJ0AfHqk7X0hwSNUnlFU9hhCbL/EHhrQ==
X-Received: by 2002:a05:6512:2e7:b0:488:a7c8:3d14 with SMTP id m7-20020a05651202e700b00488a7c83d14mr20912776lfq.273.1658343630780;
        Wed, 20 Jul 2022 12:00:30 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.63])
        by smtp.gmail.com with ESMTPSA id 4-20020ac25f44000000b0048a3c5e09c8sm2329237lfz.199.2022.07.20.12.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 12:00:30 -0700 (PDT)
Message-ID: <a2747f00-99b8-10a2-edf5-7dd6fd7a1f8b@gmail.com>
Date:   Wed, 20 Jul 2022 22:00:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] staging: r8188eu: Inserted empty line after declarations
Content-Language: en-US
To:     Abhijeet23081989 <abhijeet.srivastava2308@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Vihas Makwana <makvihas@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220720160217.70966-1-abhijeet.srivastava2308@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220720160217.70966-1-abhijeet.srivastava2308@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhijeet23081989,

Abhijeet23081989 <abhijeet.srivastava2308@gmail.com> says:
> Warning found by checkpatch.pl script.
> 
> Signed-off-by: Abhijeet23081989 <abhijeet.srivastava2308@gmail.com>

Please use your real name as you always do when signing documents in 
real life.

Patch with above S-b can't be accepted.




With regards,
Pavel Skripkin
