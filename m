Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3847B5301C6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 10:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbiEVIBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 04:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiEVIBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 04:01:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA85C28702
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:01:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu29so20875532lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pQKO/cxB7/VYjoKXzNeiz1Xd0CQDsrCaQ6n8Wg9XvHU=;
        b=vUA3xyN3O1PAx4bFjsSX5MnULZiCPblpEsKyQvAkATqhIPucetTCYNDMITpcHzXwtf
         cTIsgNfwvuWOhCYkmoYk4OHSaO2xSc7Qo+CXu1WpjvkcF5Zl6641VkOMNUOi9C0QujbJ
         hA095nxxXpQbPJ7dCqjVSYNsMNSHs2tNPAY/aRjYBmJYvjq1ytWD4S56MLwTLniGvu0k
         5yE8a+sltUNYypBBjJv1EtH7UdY2a3jyBz7+hWxqUzEwZJIO7Q/O/8f0CQovKkG+NxBp
         rVMxFeNZF1fyLfMNj4WGBoAG2gKGBXswKopqorCgGHZDz47ya/pYf5ZrGaJV/4+iR8VC
         toIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pQKO/cxB7/VYjoKXzNeiz1Xd0CQDsrCaQ6n8Wg9XvHU=;
        b=k72SvAn2wBqyejE2BMbW4QdiB6c1yFoLiJ/zvZk7ED2NdledHRMEde+Wn0NixD5sru
         5cM3GR7M4k//tawS/laX2J2KSHXlMu2TMBq9MOW9KY/3dU9OGXWer3JND0kWcpNKx6tw
         oRUdwzvLVws0S6fS3/3xwoBDaQj7wEKj72mYPNXqeut7njFhFjhCwTi6lJlSttoju/SE
         /TLg5hnYLXHmVNrXdxbQWVmdfd/bx5oPtfEI1xRf7G5NdUdAEpeJhzyBMcMsTX9WxJ9w
         3Q7KLyQX2iJuI7uvg2F2Co5fPOwKd6Hn58LvXsWlLNQQOypyOInrsf34+5ZHHlyK+YtE
         UOMA==
X-Gm-Message-State: AOAM531Y43K1j5Vm9RCi8DbXMgoesV2En5XPSZ1lKbLPrJTdnWhGVNjz
        GEjoHKqEPDJwPBztccxD5Y++tw==
X-Google-Smtp-Source: ABdhPJyR6Ils+0NmF773MvX29eTsn2y3sgO+yjLSxBUo28ij2hDLfg0TbqWeHRyTVCKFYL5AYTvK6A==
X-Received: by 2002:ac2:4d95:0:b0:478:5eba:af65 with SMTP id g21-20020ac24d95000000b004785ebaaf65mr4455655lfe.160.1653206506141;
        Sun, 22 May 2022 01:01:46 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w4-20020ac25d44000000b0047255d211aasm1356356lfd.217.2022.05.22.01.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 01:01:45 -0700 (PDT)
Message-ID: <a2bcac04-23ad-d1ae-84f1-924c4dbad42b@linaro.org>
Date:   Sun, 22 May 2022 10:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 5/5] dt-bindings: arm: qcom: Add more sc7180 Chromebook
 board bindings
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        patches@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org
References: <20220520143502.v4.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220520143502.v4.5.Ie8713bc0377672ed8dd71189e66fc0b77226fb85@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520143502.v4.5.Ie8713bc0377672ed8dd71189e66fc0b77226fb85@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 23:38, Douglas Anderson wrote:
> This adds board bindings for boards that are downstream but not quite
> upstream yet.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Normally this bindings doc would go together in the same series that
> adds the device trees. In this case, Joe has been sending patches
> supporting these Chromebooks. His most recent posting is:
> 
> https://lore.kernel.org/r/20220510154406.v5.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid/
> 
> If he were to add this patch to the end of his v6, however, it would
> make things a bit more complicated simply becuase it would cause
> conflicts with all the other patches in this series. ...so steady
> state it would be correct to keep it in the series with the device
> tree files, but for this one time I think it makes sense to keep all
> the Chromebook board bindings patches together.
> 
> (no changes since v2)
> 
> Changes in v2:
> - Use a "description" instead of a comment for each item.
> - Use the marketing name instead of the code name where possible.
> 
>  .../devicetree/bindings/arm/qcom.yaml         | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 3d150d1a93cd..277faf59db57 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -263,6 +263,16 @@ properties:
>            - const: google,homestar
>            - const: qcom,sc7180
>  
> +      - description: Google Kingoftown (rev0)
> +        items:
> +          - const: google,kingoftown-rev0
> +          - const: qcom,sc7180
> +
> +      - description: Google Kingoftown (newest rev)
> +        items:
> +          - const: google,kingoftown
> +          - const: qcom,sc7180
> +
>        - description: Acer Chromebook Spin 513 (rev0)
>          items:
>            - const: google,lazor-rev0
> @@ -364,6 +374,48 @@ properties:
>            - const: google,lazor-sku6
>            - const: qcom,sc7180
>  
> +      - description: Google Mrbland with AUO panel (rev0)
> +        items:
> +          - const: google,mrbland-rev0-sku0
> +          - const: qcom,sc7180
> +
> +      - description: Google Mrbland with AUO panel (newest rev)
> +        items:
> +          - const: google,mrbland-sku1536
> +          - const: qcom,sc7180
> +
> +      - description: Google Mrbland with BOE panel (rev0)
> +        items:
> +          - const: google,mrbland-rev0-sku16

Similar question to patch #3, this could be:


+      - description: Google Mrbland
+        items:
+          - enum:
+              - google,mrbland-rev0-sku0     # AUO panel (rev0)
+              - google,mrbland-rev0-sku16    # BOE panel (rev0)
+          - const: qcom,sc7180

and the file gets smaller and easier to read.


Best regards,
Krzysztof
