Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B5354EB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378868AbiFPUtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378734AbiFPUsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:48:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC63981B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:48:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e24so2374100pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5B/YPBqE1i3XYaE736ZQJ2S0S9D1ypIuY4zrve4dG1s=;
        b=TPYF5FmXJNP608UOhddPidwwhlgQwZqQcb5S/bcTJqHYWPar9mVox2HtlXJdbKjwUU
         RuVpNqBgeu3ym2EsTdZb1V+Ha2G8FK9KhLFUBgjMdIxwA/TJNkSFqIYPPYuxV0BtXS2r
         jRguzPoXEb8vmuIRGX1gv9h2+KOrESm2Gmo1jlTCyjBBya8CzXhr159MCFvtn30Yis7+
         dR+3zKb+lHnDtxfkDs6gvy9wM/9/8FVjcjJJX0x+esC8GAe6otnAj+EAiyukH4eIF/eM
         OVWbTpvfdRKDbfxQBiQpYaRzKGfYhHDwaQBgrVdeIbkBNZjpRy+9iZlVdVD2VldeTlMh
         45Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5B/YPBqE1i3XYaE736ZQJ2S0S9D1ypIuY4zrve4dG1s=;
        b=exGDo3c2WnusP6Xe84vrAqXd0MGc+Ol6+U+VZewPoLabjH2pFYI+U+fhHgVaY+r5HK
         k/Xh4obkLtdQvTRFhylqTDMwfpzYfYeSia7D6V48kekjDGMM08290eu4qMPQ9OVf69H1
         pIFb5vpgWtxQIiaTwFuAEp1D7fJSI9/G9GXuq406EBSGPpNHTJ+HOrMOttkbXXEewatg
         XrUZ19zfV8MYiWVeNMylVDafuCa1yAfzaVb4b1eimO2jeYjDZ/RD6tkEDwG4CxwDV7eB
         gDGUD0OsFtwaWPFNgk7KtvWykxq/uuGFgELsle1xJ6hRtkrZ+ROGd55Qbroo3lrQYoQB
         H/tA==
X-Gm-Message-State: AJIora+33ITnqYeE+wBa0e9o+3Phf1DN5rT3rGU1MBlN1vOGuK29XHjD
        hes58qZAe5JwKJgLeq6Pj19Wbg==
X-Google-Smtp-Source: AGRyM1sXiNVSP9UuwIb+c0Qc2nM5vMtaLbW6JXD81fUTqZePRAebivsREb7eIoGboiPjOHruHfiQqw==
X-Received: by 2002:a17:902:e80b:b0:168:b645:849e with SMTP id u11-20020a170902e80b00b00168b645849emr6157852plg.26.1655412480916;
        Thu, 16 Jun 2022 13:48:00 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id 203-20020a6218d4000000b0051ba0ee30cbsm2165453pfy.128.2022.06.16.13.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:48:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     soc@kernel.org, Viresh Kumar <vireshk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: spear: adjust whitespace around '='
Date:   Thu, 16 Jun 2022 13:47:22 -0700
Message-Id: <165541242280.9040.16469082540600574073.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526203815.831383-1-krzysztof.kozlowski@linaro.org>
References: <20220526203815.831383-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2022 22:38:15 +0200, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> 

Applied, thanks!

[1/1] ARM: dts: spear: adjust whitespace around '='
      https://git.kernel.org/krzk/linux/c/194f47c31ab6c37e4557eb60b382704296c10925

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
