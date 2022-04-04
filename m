Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB14F1E7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbiDDWK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380507AbiDDVVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:21:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E1A31357;
        Mon,  4 Apr 2022 14:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DB6AB819DB;
        Mon,  4 Apr 2022 21:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EF6C34111;
        Mon,  4 Apr 2022 21:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649107110;
        bh=2MFBSXfZ3tqekRBgiYDJufp0daex8Cm6j3gRGmigYc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aA/qpq3/DjEcJdSppyeto3ZRmFM0a8WjC9n9jVNNvBw15zoxpXgzFqQR39jcQASC6
         ePU2vamYPT/j39J/05ZpBOBZuIfasCs7j6Q4R1UMqVTE6P3329sdW9i5PR6QAujIHH
         HDlBaOostsy/CJKKirYrFBxbyn0x3WdUPkW3f0M5L0XtTnnLSgyISsEVdB3mqI0MZp
         KLZsjjMF/SRDmoNDystXRXJKOIIM4wDelwoNAQQXW0Sjnw8xH7NbLQfM/MBDAaSXgL
         +K0N/f7OC3Ji8E/sihBt4x0Bl7waUHV8M0Z8ZPP+fiERNkqCSJ/H4LoeiIE3ZgD0sk
         RW9JiI+8yvQbw==
Received: by mail-io1-f46.google.com with SMTP id z7so12966029iom.1;
        Mon, 04 Apr 2022 14:18:30 -0700 (PDT)
X-Gm-Message-State: AOAM533tHn3V9zonrRtuYyXFB+SkmRJcxmhocjXrwZS9pXdxELMHcuqK
        kRpzxgWuXeKeZEk4MiTBRkL1HM+OaCdSBezujg==
X-Google-Smtp-Source: ABdhPJwATjUBuVkxonnV8pK5+2/qD+WTsPj3L7mqbhvekuXa465j73EULKK5S8ov3InZONGcDfsngm0ogv9Ext2ciys=
X-Received: by 2002:a05:6638:1301:b0:323:3b47:8b3f with SMTP id
 r1-20020a056638130100b003233b478b3fmr150659jad.291.1649107109921; Mon, 04 Apr
 2022 14:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220402192819.154691-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220402192819.154691-1-krzysztof.kozlowski@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Apr 2022 16:18:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKuFAY4QENRb3dKETKcaJm-fcguoCFOgUnzf0Pwmf1Ezg@mail.gmail.com>
Message-ID: <CAL_JsqKuFAY4QENRb3dKETKcaJm-fcguoCFOgUnzf0Pwmf1Ezg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: white-space cleanups
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 2:28 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Remove trailing white-spaces and trailing blank lines (yamllint when run
> manually does not like them).

I assume you mean run without our configuration file. I probably
disabled the check because I didn't want to go fix everywhere. If we
are going to fix, then we should enable the check to not get more.

Rob
