Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CC449C3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiAZGpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:45:20 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:6512 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236791AbiAZGpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643179519; x=1674715519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2L5otQDt3DyQnhwBGZHWZVEcO2PXiUky0/SidK2N0pk=;
  b=OMxG5/Ai1KStEQb/aN/bM0GIjmoN62m/foIKOM6CfFyExfNOUmX3J4b6
   Kd2um03L4z8X9RUlriBuxZ34Rc/yvLTYab1IP2NKlVpMvMXljG/Y7bosb
   VnaVi6PdW9oK1vAJkxy8GZp0YkARKB+lTFhiJssTJZqPHznkS7FS8ElzU
   wRko9gZlEpXEKED4p45bK+E/8kH/9LmVSCfbOLlwuy+Gs6BQnaZj9d+va
   dP0Ugz1qc3KUak7kdWdXfCj1kgVUV+ob06i+/4hysAAKf6xSDZWecjeEz
   pn0NDa25JLwEvY328cbXPtT5tBUkCBx/xEpHVm6aFvysCYfz64IbRlaDo
   A==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635199200"; 
   d="scan'208";a="21710630"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Jan 2022 07:45:17 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Jan 2022 07:45:17 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Jan 2022 07:45:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643179517; x=1674715517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2L5otQDt3DyQnhwBGZHWZVEcO2PXiUky0/SidK2N0pk=;
  b=IKLuAl3+Dstmu+gHnB/vneK0GgjziCQDOfc7rgV2yhLrG2uhEpjETHJX
   iIipRevc4TUduZZOPISQZQgC4DzAnGZ+/s9q+q5DPo7MQ432cAoImZZLM
   ErWsmqZi5lt0q6RioDPKoAffVHCcDRu1O1+ASxlZshzrDIBur6P3RRL7Y
   4w6DxrXiGOLINpO5JzyDSEclWCRhFRhfosFNgk1eMglkyZnQnOkP8wRGU
   ErO8/wdWLfcM8NMRpMvFNphzZcPXefVJsgTbwT2KshhQgh06Nc7NfxBRR
   BWZTHeR6qgcipHu8g2BOxjH5WqMeporJTwJZvhN4r5hZ5e8tV04Dz9JyE
   w==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635199200"; 
   d="scan'208";a="21710629"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Jan 2022 07:45:17 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 760BB280065;
        Wed, 26 Jan 2022 07:45:17 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-media@vger.kernel.org, aford@beaconembedded.com,
        cphealy@gmail.com, Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: (EXT) [PATCH V4 09/11] dt-bindings: media: nxp, imx8mq-vpu: Add support for G1 on imx8mm
Date:   Wed, 26 Jan 2022 07:45:15 +0100
Message-ID: <8346301.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220125171129.472775-10-aford173@gmail.com>
References: <20220125171129.472775-1-aford173@gmail.com> <20220125171129.472775-10-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 25. Januar 2022, 18:11:26 CET schrieb Adam Ford:
> The i.MX8M mini appears to have a similar G1 decoder but the
> post-processing isn't present, so different compatible flag is required.
> Since all the other parameters are the same with imx8mq, just add
> the new compatible flag to nxp,imx8mq-vpu.yaml.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> 
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml index
> 9c28d562112b..7dc13a4b1805 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> @@ -5,7 +5,7 @@
>  $id: "http://devicetree.org/schemas/media/nxp,imx8mq-vpu.yaml#"
>  $schema: "http://devicetree.org/meta-schemas/core.yaml#"
> 
> -title: Hantro G1/G2 VPU codecs implemented on i.MX8MQ SoCs
> +title: Hantro G1/G2 VPU codecs implemented on i.MX8M SoCs
> 
>  maintainers:
>    - Philipp Zabel <p.zabel@pengutronix.de>
> @@ -20,6 +20,7 @@ properties:
>          deprecated: true
>        - const: nxp,imx8mq-vpu-g1
>        - const: nxp,imx8mq-vpu-g2
> +      - const: nxp,imx8mm-vpu-g1
> 
>    reg:
>      maxItems: 1

Is there no rule that items are sorted alphabetically?

Regards,
Alexander




