Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705A052EB8C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349013AbiETMFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347481AbiETMFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:05:35 -0400
Received: from sonic311-20.consmr.mail.sg3.yahoo.com (sonic311-20.consmr.mail.sg3.yahoo.com [106.10.244.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D1A153532
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1653048331; bh=pFufFWe4/hvmh/UF2IjAYcVzbttmJoCx8ZLbp3kR0E8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=YCy48Mz8g+UkIV/EpD7gcgXPx8n8cAB4OczEffGWZC3659lMHdJMLoFv3PnUQxC0fDxGDSCNXDzOhaemHXQsxASzzr4vCpqC7/74iXdsB6yRirCB3enYeO5xWNGlKZAEIEY/tWiox8U6hTJjio3XgyFJvDpmw+nHHWl1zltR8O/cwNvXTQtD8E3tcgBD78yc3w6OWLI5nXPSezDzuDTXFA151bM42z36Ptn110YhCWa3txt9qs5TUGlFvomXVPohcbvTFoi+6CUDCeAxFQfs+WxeQOLaQxDRMcv58PVG5gNuroF+3wY+Y2N/nTWd5CXaOmdrqRLoKncOPqWvTgz/lA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653048331; bh=YI29VJIeYCgJ315CB9tdDL2xAGVk878OvS9xtMfIFgt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=TC4ByCPO08h7eLG/BAvdF9IyFeQ+/oZ6O/TtcxCXYLI7xVj/eYLLPmwDpVQe4qJY16L9Xg+gKm+B70QRUb0TL/xVSDqq7kuNJefHdYY/BHqmRpMgHOOWFHXI6dZhxNLoxbE2H8Ft1q6mq1r2atAqheEDnaZ70Masmz4C3gIpmQAVcrz1AQ4rXpgyMRpccW9sBCt955zzH587mqvIgzYx4gumxyIJvN+DEsOapRMWKNzWIXE0L3gi2ge9QsPWhM3YugIRkGI87EJcn8B84LD9ItsG7Bv9jwpP07tBiqi+YlTLYkrVgJqhAc4Su/hGrD9acgf844zi9w1HvhlNFVLiNw==
X-YMail-OSG: .YWoDjwVM1kOiPTFTpiqYm2Z3pdn.Z.e3eQErRN3Xb4Cu_Pz8BM0dmQOflQKF1H
 0rSxIkejSVGViLgOH6OPMaLdkh0NbgRtssBiH2LH9PnoeM7QIVLJ.aSC9046FXzDYMTgGhst5RzR
 N_t0ALVqapv3kNkYjkG3TIoDPPxjPgIaqvADWQJEl5c7KUS5wCX06Dh2WawS2nZhn_CfPV225SrE
 ovLpCsA48utdW4WyG4XehyBpQjNChemKqdgWmj6UwnjhoJuimu6XYXVpKfQ.ZF0VLGi3owPdPztQ
 DCzExFJVeK2GFig9wn1O_994qqzMUgpZzH6EFVe97Ye_H.InPvHZVJEuQu1JwiAQTs0kQZG3MCVq
 uMkWPYIfNd4PoQH68ddsu32FqHloB0fTMITxa7paR76NdfLKltyLgcKTR6XwjJtdXHJjG0HIjZA_
 InUpVKYdr9dUbMoQNZoYVFiMh5eMfI6PfcIjxAz07IV0pGvae49zFgsAtaeV5RknWZa6LPXpUn.F
 tim3.6PjTsS_7FltnMYFtLrHMWBJUvbJB4wCioPMRZrFMi85rTwzp5sFJWJE3rIybxhoy7ZdJhwn
 qkCsCxymeXhbn82UcD3Whi41QJ9AJSJI5Sxn0Mescrk0B8soWQibsYA3h8kQEXXT0riznd1j5pBt
 WehMRYxsIO9XpwUizcVqHgJdCQASGNRLEQhwtD57XuQgAFGnCWWC4sXSPARiKP5zys1O_M65psvC
 NYN3BrjtR0wSBzbgA6noBpiqB0O7Wp.3ULlUZTnkVtOgGI6Cw_A1QNvb0loVT8eEb2v2HHXJaFxZ
 wP6XHaOEb.e02mqaI7KQrA8Q7nPlwgm0NvhLIussMxUTG9OU_.0jj94C8sd8ejNxj6AgZnQTJevC
 Y1d2A3TIKmpEarfjMkhM5SRkWiHDYMejxHQ9ZV03Zw3IU86y7FhlfLeVvunYR54jbRfplt5swIkZ
 TYYpfXjSbaJTTQH6eWaFqhjdIozlW4VruoNAjgRCpDajIJ4Bdiihk.5p5BPBezk1JFFXlEp4mRfR
 SNvhWbuGzIkzEKk2lCQmiAp2guSzpY14XoV2V4zlwHndxYx3Z7pUeealmYUyh.pa.IgS5.eq9Dow
 Z.C2iVxZJWlRAbqjkGg30HmCAhMsTWZrh9_hzwneYZMUSMacbHOSX5TG1UbNN3qy8pOtZ4rqF9rP
 X4l3A.I7ApkiBfPKUmKxVLdPlHdA55gCaKuDhjfwOfo50ZnJWRD_ewc1Z1stBLtMB1KbKFSZ7CDD
 TBjHfy5IsuB6tS6Ehwo3aRzoWwiiRdXt2JL3m1qeNDRy8m24b.YnTuq4WlEqDC5F4mNSvjKosbz1
 mqBu6y8q7cNQAfDdd7k_CqL7IsRpax43Z49.M6PhGKO8BpxwPejv5TLy4uwEwggvSLw2KxqRi87r
 EhdoTQBYLy5GGCStFQNv8RWgYYyQIkIT9GCmvR3OUAfSOXBbh7feh6uZW3d_szigvnnKGuc3z83.
 KWiUQJg9X9yE99jexq.iM9ntaZLkANAIjAUzFPbPXwTzS94cmD6lTXVO9IZl1vzlDUZragOpJUk1
 f_BA9kh2Yhb5IpA3PXWMACuOqb3fZLZJbzWIGaEwXm88gOYekaTPbpS6z_Y1eIvoE0fL0E6NyHdT
 8HkaomxIudjX.Jk8SjVBhb57VhjyGGxZjZbmNV23MsWB5pz2Qd2nKGlUxVK6sJPu8JwOdE0zTseu
 9ZFJZL7O9h3QCkzse7Jof2Q78DHhEKd8xRWcTPjIIIjcTvpiy0PE3gDcJV5R0O1xT3eVaRSkmYuZ
 FoCb7kuacEEDvVPo3N5eMdZBSYAOnIOfkEt3WjXn1iYGvS5l4fq4OcO7f4VUEY_6Ue.YdgfkF0GB
 VEuOiOmloB3Fkq5FSummENGNOeDqwrxKeylTYxZmyjWwzMEFDdRyPaUbMkxc4P8imAHyDrVZHWAp
 6o34N.299fNeiNIVEI3TI9_URHVaSoyGpXeqnvn61CQCKuhrrvogtuwJGRuTFdThQPfTOZ2JwI6N
 UT2RUlVselR2O5wcnsgyqP0X8IV4kkU8aX3rCJlmRj_DK4VfEtmfktmX_ZVMHnRLf1u4stdvUKRP
 RP6XrHj7pca_Xj48ObQylYFEnm5Zw9bgE1SQh7tsaRERPD_fxJYLfEPyW7HgL8kS7C_y3WjI6Lv2
 lv9y.o5MJ7ULxbqL2rEcTZ2iCpr4ukI4E2jEPrwT8TnPEVm_J7jlMSxdqJzt0ZbejL4HDjScwMe4
 UKjqY8ZrCF48nvGRi4m9MsZaxAaf558wQCs2X.rdX5ZCPGMWgiqIkuyMEJVEuToG5l6aKkQ6no2I
 eNy6.f0jCCQsK3S0Y1ekn
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.sg3.yahoo.com with HTTP; Fri, 20 May 2022 12:05:31 +0000
Received: by hermes--canary-production-gq1-5cd7967f4d-rdzjx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0e81e43a2f3cdb966d184af1e1a1edda;
          Fri, 20 May 2022 12:05:27 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Document xiaomi,natrium board
Date:   Fri, 20 May 2022 12:04:48 +0000
Message-Id: <20220520120449.12996-2-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220520120449.12996-1-ae40515@yahoo.com.tw>
References: <20220520120449.12996-1-ae40515@yahoo.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Xiaomi Mi 5s Plus (xiaomi-natrium) smartphone which is based on
Snapdragon 821 SoC.

Signed-off-by: Alec Su <ae40515@yahoo.com.tw>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5c06d1bfc046..7ee852079d13 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -190,6 +190,7 @@ properties:
               - sony,kagura-row
               - sony,keyaki-row
               - xiaomi,gemini
+              - xiaomi,natrium
               - xiaomi,scorpio
           - const: qcom,msm8996
 
-- 
2.35.3

