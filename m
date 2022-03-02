Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43EC4CB149
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245287AbiCBV2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbiCBV2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:28:18 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98FC2FFF9;
        Wed,  2 Mar 2022 13:27:34 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id j24so2967422oii.11;
        Wed, 02 Mar 2022 13:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0jA6Eh+79xm1xtrjYSGEg4y5N0x89Kt1VGWaNVpVII4=;
        b=dql3vuyIAdkn4KqXkLvWiEkSYI0KZOkyFw3GIWdfT+7sKsnY499LnZtiBMYn5S25Jx
         8t1JLjlJE6vpLKjTZzbJPZEXOAj1kY27ho6Tqe87dDyJ/lpdip0I3VgzghRJ7RNp6jLc
         BTxStzw0HoYwUDuQZ3Zt18N7AzjLs7dF1O8DxApWrfJ1iAOTMQIe6kbEjiaUlPgsh6Zg
         Cs1TfXqCpYNovBGRNiJ/whgctdcMnXq95yaVvlR/VuzT0SmCFCmx4brLIVrEeEfvf/V+
         +Ih+KaqNBVldB4Xuf74FAlgweYl1O9hoxONYjTiJemuiOhdB6jydbNFEedMa9gbodk9A
         XFsw==
X-Gm-Message-State: AOAM531t70AT4254NzKTSErebXD6w8/ZCXDqTC47EuoCCvR1CibZcnnZ
        dB2O/urqMB9vwiwibmHilg==
X-Google-Smtp-Source: ABdhPJxLO0sMTT3/U3oiHDRNRUnjKE7sRNRfX+ENHmYSZL+RTK44W+edCJhklycRFu2CQy3l/Nj3VA==
X-Received: by 2002:a05:6808:30a3:b0:2d5:2019:97ac with SMTP id bl35-20020a05680830a300b002d5201997acmr1770192oib.40.1646256453991;
        Wed, 02 Mar 2022 13:27:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bh42-20020a056808182a00b002d538a8d5afsm79314oib.7.2022.03.02.13.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:27:33 -0800 (PST)
Received: (nullmailer pid 80731 invoked by uid 1000);
        Wed, 02 Mar 2022 21:27:32 -0000
Date:   Wed, 2 Mar 2022 15:27:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Han Xu <han.xu@nxp.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: Update NXP Flexspi maintainer details
Message-ID: <Yh/hRIA1eC6xD684@robh.at.kernel.org>
References: <20220302192915.6193-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302192915.6193-1-singh.kuldeep87k@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Mar 2022 00:59:15 +0530, Kuldeep Singh wrote:
> Add Han Xu as flexspi maintainer.
> Also, update my email address as previous one is not working anymore.
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
