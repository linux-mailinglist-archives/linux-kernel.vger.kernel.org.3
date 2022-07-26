Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75510581C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 01:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiGZXmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 19:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiGZXmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 19:42:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB830183B6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:42:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e132so14459778pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dGH3qFzh7142lQz4z3uuh5FEAq1YCKuXhD8gTq8Wv9o=;
        b=jw77WZsx/pqONraLzY7S7Om30Dy23eEzwf3gwh67jG+4Bt8oewkXkZfewyUyDbSux/
         78NMnQFG0g7o1IfO/GBs3yyFgojB6rMDFnxInnTLJN56ZvKbZFWHVAm1j5T1J0fJ5dnb
         oZT25bEUTj08EwEg/9vk0CXnqbPoZGTIOjx3whGKvUiKiJEjCuQaL+gv9sCCa7WLLmyU
         13Ggu4CXecU/6QwKB203FGwa7ZyIo9Pux72qickqTrv84jkgMe9SLr20quD6ts9anRss
         uaHCeYcVZHlA5ZK8ICkQrCYr2Orw/F9YpMa2NXpNSPzAT8STPqs8fYYy/okcpop9bsge
         Potg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dGH3qFzh7142lQz4z3uuh5FEAq1YCKuXhD8gTq8Wv9o=;
        b=nkDIci+LfAEkJ9Kwk9dSxBQzCP7YI08GBqBdYWtPSJ6Gu4aIlBlK1tmrFENhyYVYsW
         +cn8xQ4yd6V+4IXrgCuLqbTfpcpznMSIlahnW/n8FkZv07f64tZT9oeiq6nGHSxcUoZK
         MJFYmda6I6Th0fFVAfpOqNy95LBTOLid29/UeE7UQHKlYijvI/T5pTzNVeEQ5dDLVv+H
         AEVz25a4nTlRv6rcZO2tUJveeFYEceRagF9dbWoURP31d0pZNpgmzydxWPAOFcrsN4C7
         OAs0tpgBwjM+pdVg03cTRP2AZO70QOF/lfbfI0k/UBzDLU9Y+X731Hdhvz9HveWB9//u
         96VA==
X-Gm-Message-State: AJIora8z+ah9+5BLgKM72MrxbXrbU9lRO8qe4bfRi5mGOFg3+0rHv/Kg
        4eSU83cF3FX1ruT/Qg+LmDA=
X-Google-Smtp-Source: AGRyM1stuefJK9kAz9r4wv0P8V9jheLIWcFpwYHQv/iGNJjcOQrHNDFP9DPBxROXTQrW+z/8MMxYwA==
X-Received: by 2002:a63:8bc8:0:b0:413:9952:6059 with SMTP id j191-20020a638bc8000000b0041399526059mr16255399pge.61.1658878922294;
        Tue, 26 Jul 2022 16:42:02 -0700 (PDT)
Received: from [192.168.0.10] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id gj13-20020a17090b108d00b001f2ef2f9c6fsm129676pjb.56.2022.07.26.16.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 16:42:01 -0700 (PDT)
Message-ID: <9380720a-a5b5-b2d9-757e-7b5b604310d0@gmail.com>
Date:   Wed, 27 Jul 2022 08:41:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/6] mtd: spi-nor: move function declaration out of sfdp.h
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20220513133520.3945820-1-michael@walle.cc>
 <20220513133520.3945820-5-michael@walle.cc>
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20220513133520.3945820-5-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/2022 10:35 PM, Michael Walle wrote:
> sfdp.h should only contain constants related to the JEDEC SFDP
> specification(s).
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

I think sfdp.h can contain declaration for a function implemented in sfdp.c,
but not a strong preference.

Reviewed-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Thanks,
Takahiro
