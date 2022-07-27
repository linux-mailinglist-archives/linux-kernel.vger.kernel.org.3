Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FB9582A05
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiG0PyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiG0PyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:54:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D512610E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:54:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z18so9605417edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hcYEJ77Wmfc9oK9k1HkYbTJDPUr0ZlLyXJF/Wi7+idY=;
        b=IX2brodF+ENxAdppku6LCWHaq5XQtN7QRKUmnOhk7Xmearpz5MjJ57+AHX9/QLLW0u
         P5mr/tyZYuepEEsE7UQJzgYRw2XVk1U4KUXURq4DaOFoRfCqU8tNmv76wscX+zug0xk1
         A2NE2VburQgP26TacQ+x3Q2k6GK67k9uCC4h2M8/VvEeGZVsT+FFfEG7mMLVO9OYQgor
         TzAwdMVBTg3g4sCQ2yhqoXL5QMt9KvDvuXKsv/qz2m4gcIxCd1K3N6cWnH7IHa/G6TKO
         T35Uq3HPsXfL8XlMGmAoGrd60mFr/4rK6qgu17aSGkr3MYYQVXVU+iQOgOqovFjCYxXf
         zbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hcYEJ77Wmfc9oK9k1HkYbTJDPUr0ZlLyXJF/Wi7+idY=;
        b=mPYcs6Cp2yCxp6ykvUnLPLc3acXzV1hBemssHRBTOXkyiMvXn3BORwhphjk9r7A8JW
         q1K1oCxRlA6TGWOOknq0bmP73Lgr7+0dSMRiXi+XGBeJ7sFwlHRygQT844G/E23/HqsY
         hLz4Uz/pZ6jzJhsdQmDh8YBLW2Lx5mURqoybwXRy3rH5x6+mxJSGpiFr7cx+fwomeS3n
         JQZ9hnBkzjUpmVzamWbkmlVMcxcfjnFddWJh7szBJsPKsHSU7mgLha4vBrCd4yx3bXAr
         aFfxIR2uSz7Jy8D+EHtUMSkET9MFUZx+QjUqNhZV73ydeplT3BhKc7165k85TnE8sfbt
         /fNw==
X-Gm-Message-State: AJIora/qeccIz1RXTYrBWpnp3BauLdMB5r1v5n0bSWjWJhFf2j3bFzPo
        1h2EnkGi9T+o1dnOAgqgxqM=
X-Google-Smtp-Source: AGRyM1vuJ6dtvrf4xPo6HhWMRBPFt2aAlGhrqJeal7+/Kwcbefs7ypWDeALzK6SahWs38lV7FK/cEQ==
X-Received: by 2002:a05:6402:345a:b0:43c:abfe:5b75 with SMTP id l26-20020a056402345a00b0043cabfe5b75mr4462788edc.416.1658937246246;
        Wed, 27 Jul 2022 08:54:06 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6917:2d0b:bd0c:a579:887d? (p200300c78f2e69172d0bbd0ca579887d.dip0.t-ipconnect.de. [2003:c7:8f2e:6917:2d0b:bd0c:a579:887d])
        by smtp.gmail.com with ESMTPSA id sb12-20020a1709076d8c00b00718e4e64b7bsm7660765ejc.79.2022.07.27.08.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 08:54:05 -0700 (PDT)
Message-ID: <4d1e2294-a3b7-972b-f021-cecee8779f1b@gmail.com>
Date:   Wed, 27 Jul 2022 17:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] staging: vt6655: Rename byOrgValue to reg_value in a
 macro
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1658333350.git.philipp.g.hortmann@gmail.com>
 <83920d919acd7596488943182f37132e479d70f4.1658333350.git.philipp.g.hortmann@gmail.com>
 <YuDfjwHJN6n/CZ4i@kroah.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <YuDfjwHJN6n/CZ4i@kroah.com>
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

On 7/27/22 08:47, Greg Kroah-Hartman wrote:
> On Wed, Jul 20, 2022 at 06:24:32PM +0200, Philipp Hortmann wrote:
>> Fix name of a variable in a macro that uses CamelCase which is not
>> accepted by checkpatch.pl
> 
> Why rename something you are about to delete in a later patch?
> 
> thanks,
> 
> greg k-h

I need to rename this variable. Does it matter if I do it in first or 
last patch? When doing it first I do not have to review so much 
checkpatch warnings.

Or is it OK to convert the macro to a function and rename the variable 
in one patch?

thanks,

Philipp

