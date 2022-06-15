Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2E654CB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348474AbiFOOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiFOOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:24:56 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064762FFD4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:24:56 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p13so20840680ybm.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0/6B+ZI7yo0LWxIckWnNt0KBdhDtWdQjkQId2wLCUU=;
        b=rIlNXD2CRCmohocx0jGUfx6WCJlJAAxujr7ifneFctCVn6xwYppYh/yQd6RHMxFRKt
         tfGIxKowBFPDASSlPOJKEsuRg0qsYKS84gA2CM8zIM/OJzOV1s/0/Si22CSMW/c3tJYA
         9eTMf1kHCEmRMa/YRySfsboC9+i/ueUqfraN9pmbbTIR7Qw/JcNo3clu9KZZW7S8mYO2
         EE2hLPRDLwBwyRpNyeI68lrXPs0qbQpzemt58GK3C5xINKJDLObwIrOH8rRU0KJ+RyYe
         ZbPyZzPyiBRly91ZJ6huP1TM7A3dlQH7XbxTWl3jZq9GfLyiEh7JMX2WKc2JJo5U4rPj
         0DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0/6B+ZI7yo0LWxIckWnNt0KBdhDtWdQjkQId2wLCUU=;
        b=eEU6Tpc9fW3MV4g1zEedO+kQHXAjeNz8CW8Ep+0EV1I6LWFrXaHQCa+3uyjzpOjAGB
         sY1jjm5JyXuZDR7uzaaXlCW0qr/NWl0VX+DrOjoQTZYyQcVLBVPhXXu58vpgAM6GtiPf
         2vlr8krRg/TfRuzTgrMZhYiSlePIf+IX4d1Dl6jG6MqpDOKxvUE5HObRGbhz0PyrXrjp
         cgu0hyorN+UElXfiAwx9fiCUZ0ee1lFbeVJi7H27LDmZADRLQPCHhhRA69h26Jz3Pzml
         Xgq1W/lExeMFibp9UHESjsn6XncOIE89XFszrphakImiD86it++rRx8VnPkzH2jx/zgo
         X7KA==
X-Gm-Message-State: AJIora9yOvSWpnypHRAtjR4+ocFzzdkhxdv9CHFGwjhiYbyj9PqJup2G
        HfZJDJZwjf4VCZ37e1HCMhYoDcEVSuQlWpNYgGz3IrKP9kE=
X-Google-Smtp-Source: AGRyM1shDK5Am3UVbdvXd8vxBgewPS67j/GYf/VHSGVjdm00nEHLH+RBI7hmP3DrfnKVxyiy5Vt7Vs9naBlh1d4dFmQ=
X-Received: by 2002:a25:1256:0:b0:65d:6433:7993 with SMTP id
 83-20020a251256000000b0065d64337993mr92039ybs.626.1655303095223; Wed, 15 Jun
 2022 07:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220607121335.131497-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607121335.131497-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jun 2022 16:24:44 +0200
Message-ID: <CACRpkdbXsugx7FEof3VeDVw+fOSfZ9hi1FQkNvc1Kfmezj+1vA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: sunplus,sp7021-pinctrl: reference
 generic schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 2:13 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Reference generic pin controller schema to enforce proper root node
> name.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied.

Yours,
Linus Walleij
