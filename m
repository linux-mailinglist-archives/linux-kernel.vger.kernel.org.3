Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95815090E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381937AbiDTT6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381878AbiDTT55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:57:57 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5893713F36;
        Wed, 20 Apr 2022 12:55:09 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id w27-20020a056830061b00b00604cde931a0so1833184oti.2;
        Wed, 20 Apr 2022 12:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Eb+af1irrOGhsjiB2GmRtBN3a0Xd+4K2svp/0w6UF0=;
        b=iAANf6/jSo8DRY93BJDULTVAJjhkCDvlS8xQ5n/jycQaMHAyQf0loEFIuUWH9bThlQ
         KYcgD03VvTSAv297dTLfsjm4Pm8qu0/FmAFjn5wvYAzyTXuNnWWqpxjHXXTeEHO2aopP
         D6pmaVc2sNFU0UZoVGsr9ltghnxC2cGdHtCQHskQs2u2Xn9IJqxMXGodwTsXvH5lQu8m
         Wijv+Q/+xbIq3nEGD8KQRrc6HTn6SnPtQGp5xCaJkpDWpkR0ma6eQYmqvW0x/dViR/Lz
         12Gwtx6J2RmMqsKf8sKGGsVSR2Uys2gFlHuDmrWSPMwz+5mNOcyLm2EEvouRRqZuusDw
         0fgg==
X-Gm-Message-State: AOAM532M0tKS0eMS+m9mcFWeJIfANj3jTZC8LeD/2dFsuu33FWzxRWEE
        QfeMLjIS0dz+lE8+ECHSNg7gYcFShA==
X-Google-Smtp-Source: ABdhPJyTTom7iJmtX/jkaOOTQsyYZxE80c+w24+z1bq5wFoAkF5MrFkUxjkaVYiouaoh1wNwsF96Ew==
X-Received: by 2002:a9d:12a9:0:b0:603:d1cc:68eb with SMTP id g38-20020a9d12a9000000b00603d1cc68ebmr8195262otg.326.1650484508620;
        Wed, 20 Apr 2022 12:55:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 30-20020a9d0ba1000000b005e95b29b95dsm6892287oth.5.2022.04.20.12.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 12:55:08 -0700 (PDT)
Received: (nullmailer pid 1747542 invoked by uid 1000);
        Wed, 20 Apr 2022 19:55:07 -0000
Date:   Wed, 20 Apr 2022 14:55:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kartik <kkartik@nvidia.com>
Cc:     jassisinghbrar@gmail.com, krzk+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: tegra186-hsp: add type for shared
 mailboxes
Message-ID: <YmBlG7SeR7Ok4Sbh@robh.at.kernel.org>
References: <1649921757-16919-1-git-send-email-kkartik@nvidia.com>
 <1649921757-16919-3-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649921757-16919-3-git-send-email-kkartik@nvidia.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 01:05:56PM +0530, Kartik wrote:
> Tegra234 supports sending/receiving 32-bit and 128-bit data over
> a shared mailbox. Based on the data size to be used, clients need
> to specify the type of shared mailbox in the device tree.
> 
> Add a macro for 128-bit shared mailbox. Mailbox clients can use this
> macro as a flag in device tree to enable 128-bit data support for a
> shared mailbox.
> 
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>  .../devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml | 9 +++++++++
>  include/dt-bindings/mailbox/tegra186-hsp.h               | 5 +++++
>  2 files changed, 14 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
