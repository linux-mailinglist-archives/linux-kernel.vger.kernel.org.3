Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA875501A1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 03:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiFRBRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 21:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbiFRBRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 21:17:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AEB6B01F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:17:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f16so4191785pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YyLn6g7vHfOuSa6wUd32m7NoZ5cRQIcWpzzoXnE6kB0=;
        b=qGiwuLye1ynOBURtscgbzmupalCPu2LwEEyvj1yDzFsGJMKFyXiPndg0CGyWgnIHqy
         S7cww702kckx6jCqb1fTNVsp1ECceJTfzLWEXrILFzZS54owJ9Oq1piAGUPK31KFSJ2y
         TbcCAV56ifzsAbBfkRBAhzEwuJ+7Ds9Ttqr0vzz4DhWedF6aeizA8m3aGpg02Sz/RY3C
         IAnzSCV2xN6NUsSZcgLuu5EyKAAMktNbUpudAAWbpRYHuvxe8GowdB23ae9rs7Uyk84y
         fMPuhCtoCZcbqoy3zGZZ3j9wvsZ85CQb7pJlbjgfK8xKhsDIMPdpRk8KUfkh6rIOBEBh
         yT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YyLn6g7vHfOuSa6wUd32m7NoZ5cRQIcWpzzoXnE6kB0=;
        b=Wz2YUm+VlX/3WX4jj8RdHhHsXO8PJvvlyOMreuWoHdN7kZQHTp6IQSRlqyZ/sM9wHE
         FdDpJoYIK/tER7rI43jaVhEZ/QdhiIYJJm3ezxGts3SeSsyP30kSvR7uQbEYFISkl5MH
         praI4zxsoBkA7osuihFtxcMirT+/1lZea7hC3a2t1djAiNiV5SH1UXaJ+JR+09/QFXyY
         lmnPRxhPtpux0lq+3mAJk+OdJXMJ7OS1LsS4sJiMx/ekG5P0WAMk8nnpqHoTEx97HPaV
         KPx60p8J1Bfd6I4lMtWhF9m4BNLiEeppqZ5FQlskgHf7anV++f21fqYK0Ed1EB6v+4Qc
         /WAw==
X-Gm-Message-State: AJIora8mJYnAeir4AQv2tctbxqGTBxI/JfsW5o7muSXqldyVoKjMaE2f
        5/UREk2qK6apCiR8NSFV8VJ1Tg==
X-Google-Smtp-Source: AGRyM1ugD6Hqyw87IEKWEacxbwyqYAnd4hfXfTEMLg8mP1rVupaS3+8mM3vl4bqVy9+M26ewy9HwMg==
X-Received: by 2002:a17:902:cec5:b0:166:3418:5260 with SMTP id d5-20020a170902cec500b0016634185260mr12357629plg.129.1655515019768;
        Fri, 17 Jun 2022 18:16:59 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902650900b00168ba5ac8adsm4155211plk.163.2022.06.17.18.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 18:16:59 -0700 (PDT)
Message-ID: <d483da73-c5a1-2474-4992-f7ce9947d5ba@linaro.org>
Date:   Fri, 17 Jun 2022 18:16:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH net-next 02/28] dt-bindings: net: fman: Add additional
 interface properties
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220617203312.3799646-1-sean.anderson@seco.com>
 <20220617203312.3799646-3-sean.anderson@seco.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220617203312.3799646-3-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 13:32, Sean Anderson wrote:
> At the moment, MEMACs are configured almost completely based on the
> phy-connection-type. That is, if the phy interface is RGMII, it assumed
> that RGMII is supported. For some interfaces, it is assumed that the
> RCW/bootloader has set up the SerDes properly. The actual link state is
> never reported.
> 
> To address these shortcomings, the driver will need additional
> information. First, it needs to know how to access the PCS/PMAs (in
> order to configure them and get the link status). The SGMII PCS/PMA is
> the only currently-described PCS/PMA. Add the XFI and QSGMII PCS/PMAs as
> well. The XFI (and 1GBase-KR) PCS/PMA is a c45 "phy" which sits on the
> same MDIO bus as SGMII PCS/PMA. By default they will have conflicting
> addresses, but they are also not enabled at the same time by default.
> Therefore, we can let the default address for the XFI PCS/PMA be the
> same as for SGMII. This will allow for backwards-compatibility.
> 
> QSGMII, however, cannot work with the current binding. This is because
> the QSGMII PCS/PMAs are only present on one MAC's MDIO bus. At the
> moment this is worked around by having every MAC write to the PCS/PMA
> addresses (without checking if they are present). This only works if
> each MAC has the same configuration, and only if we don't need to know
> the status. Because the QSGMII PCS/PMA will typically be located on a
> different MDIO bus than the MAC's SGMII PCS/PMA, there is no fallback
> for the QSGMII PCS/PMA.
> 
> MEMACs (across all SoCs) support the following protocols:
> 
> - MII
> - RGMII
> - SGMII, 1000Base-X, and 1000Base-KX
> - 2500Base-X (aka 2.5G SGMII)
> - QSGMII
> - 10GBase-R (aka XFI) and 10GBase-KR
> - XAUI and HiGig
> 
> Each line documents a set of orthogonal protocols (e.g. XAUI is
> supported if and only if HiGig is supported). Additionally,
> 
> - XAUI implies support for 10GBase-R
> - 10GBase-R is supported if and only if RGMII is not supported
> - 2500Base-X implies support for 1000Base-X
> - MII implies support for RGMII
> 
> To switch between different protocols, we must reconfigure the SerDes.
> This is done by using the standard phys property. We can also use it to
> validate whether different protocols are supported (e.g. using
> phy_validate). This will work for serial protocols, but not RGMII or
> MII. Additionally, we still need to be compatible when there is no
> SerDes.
> 
> While we can detect 10G support by examining the port speed (as set by
> fsl,fman-10g-port), we cannot determine support for any of the other
> protocols based on the existing binding. In fact, the binding works
> against us in some respects, because pcsphy-handle is required even if
> there is no possible PCS/PMA for that MAC. To allow for backwards-
> compatibility, we use a boolean-style property for RGMII (instead of
> presence/absence-style). When the property for RGMII is missing, we will
> assume that it is supported. The exception is MII, since no existing
> device trees use it (as far as I could tell).
> 
> Unfortunately, QSGMII support will be broken for old device trees. There
> is nothing we can do about this because of the PCS/PMA situation (as
> described above).
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Thanks for the patch but you add too many new properties. The file
should be converted to YAML/DT schema first.


Best regards,
Krzysztof
