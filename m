Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805FB54CF6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbiFORKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiFORKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:10:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D6C33A33;
        Wed, 15 Jun 2022 10:10:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o7so24540204eja.1;
        Wed, 15 Jun 2022 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=vY67WMB2Agt8pyrPhfTXeIIIQFi2KT2b5ifqCXgqTGk=;
        b=dsBlgJahY582AAuGOeZC9sw97KW5Ea0ZlJ6v0H+ha5ozYOrCq32CuUEfuntuMgCOvP
         T3aV/bVnyOHt03HrUECwBufspZdyyNfQAGaxphguo6Zqc712QDFjXBRNrXwS7HKP1G2n
         e0Ps31jm5W70quEOpIFTINUcFwLSFFYWRNq2Mvkp16xrTiegBlkGNXz0VT2R2hSKrSN2
         IoNXVP+CKhQm99tmeuva0edqFLZBoB8e0CmLaiOa/ICfB2ycHOpmzVgatWWZTdjBb0Pi
         J0yGILitm1t5tqUYlpCpRhc43SFh43IDbpMSFi8xrzntsjwX3sqCJRouRd2gm7DNwgFw
         ITqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=vY67WMB2Agt8pyrPhfTXeIIIQFi2KT2b5ifqCXgqTGk=;
        b=IngQu+JIpvAs1EYPRAT8vsjBgs/5/h1jBRzWfo8PIf1jE0DnOZDekpNZnz+sd6QAH2
         WaL9xKIATrjO68ZvHqZ1QwwDRWl3vIFJsRFl1EcUMZv4TmdZb/fjkGLuoct+yvBx/FM2
         xVSwLwt8Qw0oNNRjpJhUHXvhZOAsF/JBVSFnl7033mUrPvknhNdOP4+k1/3rIyhuzGC/
         Tb16aZiVIuG4kKSOje9Vo/karUSRnUM/9Ew3U/bwBmuin3pxSFbYAaJOT7/eq0DaSBr0
         x2px9/Y87qJSm9LCHhUqmFqvldQwEvSs2+T7qL1KKytLPaYIZvEqJfZ9U3fMTq2zDfsS
         910Q==
X-Gm-Message-State: AJIora8XZUvbboxA9U1b2zycKjsBk5SLVjfFwLdZLk2t1tZEG6mefUzk
        ZD7T/YlJi/P2kgcf8EoYxqPGGgPUvnQ6YA==
X-Google-Smtp-Source: AGRyM1sZeBSTelg+26G4wbFPs6/9pqx6I0eJb7g0zhPvt6MuSLzJILwPZWyhoJVRjgTyRPpZQM9zTg==
X-Received: by 2002:a17:906:2245:b0:715:7c81:e39d with SMTP id 5-20020a170906224500b007157c81e39dmr758896ejr.262.1655313013990;
        Wed, 15 Jun 2022 10:10:13 -0700 (PDT)
Received: from [192.168.200.12] (p3ee2b977.dip0.t-ipconnect.de. [62.226.185.119])
        by smtp.gmail.com with ESMTPSA id v20-20020a1709060b5400b0070662b3b792sm6433336ejg.222.2022.06.15.10.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:10:13 -0700 (PDT)
Message-ID: <d80789bc-a8fc-de5f-164a-75adf7097311@message-id.googlemail.com>
Date:   Wed, 15 Jun 2022 19:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kenneth Chan <kenneth.t.chan@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Seyfried <seife+kernel@b1-systems.com>
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
 <20220612090507.20648-1-stefan.seyfried@googlemail.com>
 <20220612090507.20648-3-stefan.seyfried@googlemail.com>
 <CAHp75Ve+vrfSu6pD+AKe-eCVA2pC5o520y4gVwLNg9Dtk0U5bw@mail.gmail.com>
 <CAHp75VdFPUHTeDBY5ukFgVqJJn7BbTHxrxKUGOLB6P1UX-utAg@mail.gmail.com>
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all
 hotkeys
In-Reply-To: <CAHp75VdFPUHTeDBY5ukFgVqJJn7BbTHxrxKUGOLB6P1UX-utAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 15.06.22 13:24, Andy Shevchenko wrote:
> On Wed, Jun 15, 2022 at 1:21 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Sun, Jun 12, 2022 at 3:54 PM <stefan.seyfried@googlemail.com> wrote:
> 
>> We usually add module options in very bad cases where it's very useful
>> for debugging or when some devices require the opposite settings while
>> can't be distinguished automatically. Here I do not see either of such
>> cases. Hence, I would prefer to see a DMI based quirk as it's done a
>> lot in the PDx86 drivers. Can you do that?

I can do that, but... below ;-)

> Looking into the code of the culprit patch, have you tried to add a
> debug pr_info() and see what value is in the result? Perhaps you may
> just sort out by correcting that.

The driver is working fine, it's just that Kenneth's machine is getting 
most of the hotkey events (I'd guess all but sleep, hibernate, battery) 
twice. That's why he disabled the key generation from the panasonic_acpi 
driver for them. (My guess is that on his CF-W5, they are also coming in 
via normal keyboard input path). My CF-51 does only generate them via 
acpi, so if they are not generated, I get nothing.
Hence the module parameter so that the two known users of this module 
(Kenneth and me) can adjust this to their needs.

Now about the DMI match: I can do that.
But let's face it: the panasonic laptops are pretty rare in the wild, so 
even if I'm "whitelisting" the CF-51, then probably other models will 
need the same treatment and we have no real way of finding out which 
ones, unless people complain. (For example my CF-51 is about 17 years 
old now and I just pulled it out and updated it to the latest and 
greatest "because I can". That's also why it has taken me so long to 
even notice the driver was broken for me. So people not complaining will 
not mean "nothing is broken" but rather "this code has not many users").
So even if I add the DMI match (which is a good idea anyhow because then 
"my" model will work out of the box, while right now I need to add a 
module parameter or switch it on later), I'd still vote for having a 
possibility for overriding the DMI results.
Would that be OK?

Best regards,

	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
  public relations, for nature cannot be fooled." -- Richard Feynman
