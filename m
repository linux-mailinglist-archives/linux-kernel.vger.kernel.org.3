Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064F059D5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 11:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347470AbiHWIsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348715AbiHWIqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:46:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390196FA00;
        Tue, 23 Aug 2022 01:21:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso16510086pjk.0;
        Tue, 23 Aug 2022 01:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1cj7sCX/819JZ2jI3ANzIO5MN27uSpxPakNGo1RmZJQ=;
        b=BO3ghMfPYRhCWjj9zSKbRzZ4wth+zDtB0V2HX4HuhRDScfcs5M14w4kaGUOsu0mB8P
         AydjXlOEW0GbAVNyht9/Gr7aE9oMXN9wHrlDyFgf87K8KsFWszJzXzGqLQtUj84v15GH
         KN+9xqcxtAM0YcTgeSFccJVwdv+aub1N/zEnYy9DGkjxVKKIAZlUf1RWhyCA3rqNt2hY
         X8vF5cQX918EELOiu9ORHLG97fccfj4zj5k0BBwJF45heboo2Wn1APjlzXMqSSZfVUIG
         88WK/hhZb4lXYddodzn888hDZwbc6oJIJgTc98Au+xW56ooBpJQtyrjNpZyEP/wCaFXD
         UaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1cj7sCX/819JZ2jI3ANzIO5MN27uSpxPakNGo1RmZJQ=;
        b=gQ5fDiTRlqR0Zx8xRkYX+lRNHXCEfvv9BNSuDl3GGoYMX2SeSzgm/VhDI0cgWIwrTC
         vcbJNqRxCd6XCVvfGMZVNUKOTbc0ZC0ToER5lhy6ImXhK8hlF98XPvj1JTLqCxPjw4GS
         PCWNjzof+EfRcS3mpYbC4m3azkIoDWA/lMbQnCO0b6eCnQ/jP47QJ28BQXMvbtLNB6Xk
         B4KE13KuxKiOK2GQTCx/oCP6eO/mrWxYKnZcWfz912S/0N9I0OmJsZD+HBQrZIGOy2TS
         cQdb9R4P7WKFBtt9vNM5I1UdGd2WGbEVBaLc7TVE+Xfy6ZboYYKbGpU1bGRgFqd6TgTx
         wmrg==
X-Gm-Message-State: ACgBeo0Y1H8pgwnojBaf7+qRL6jDH4TpTkq9sm1fQ3TcsaJwKqnmWHXI
        Iez7QzNcJvopsju1MjMQbnM=
X-Google-Smtp-Source: AA6agR7cSqq9FjNLrxj/uIIBjb+sMbLbWrl6PYCXuZ5wSdpx/KtwNwRsGD8LAzqZN5GqzxV3ybZecg==
X-Received: by 2002:a17:903:22c6:b0:172:cad9:403 with SMTP id y6-20020a17090322c600b00172cad90403mr16811432plg.123.1661242893190;
        Tue, 23 Aug 2022 01:21:33 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-56.three.co.id. [116.206.28.56])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001641b2d61d4sm9880362pla.30.2022.08.23.01.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:21:32 -0700 (PDT)
Message-ID: <e238c1b9-8c9f-c5f1-fd5e-2be94f150477@gmail.com>
Date:   Tue, 23 Aug 2022 15:21:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] MIPS: ath25: clean up non-kernel-doc comment warning
Content-Language: en-US
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
References: <20220823025441.30708-1-rdunlap@infradead.org>
 <CAHNKnsTdmPMwYa1f7DBJsEXxL_pzforPLar=eO6Jp=COmCXrtQ@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAHNKnsTdmPMwYa1f7DBJsEXxL_pzforPLar=eO6Jp=COmCXrtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 15:13, Sergey Ryazanov wrote:
> Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> 
> Randy, Bagas, which one of these patches should be applied:
> * https://patchwork.kernel.org/project/linux-mips/patch/20220823030056.123709-1-bagasdotme@gmail.com/
> * https://patchwork.kernel.org/project/linux-mips/patch/20220823025441.30708-1-rdunlap@infradead.org/

Hi Sergey, thanks for replying.

Oh, I don't see Randy's patch, since it wasn't CCed to linux-doc list.
I prefer to choose Randy's one, because the description wording is
clearer.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
