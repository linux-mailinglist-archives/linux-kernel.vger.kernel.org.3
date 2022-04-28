Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35B4513AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350513AbiD1RbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350490AbiD1RbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:31:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF850E27;
        Thu, 28 Apr 2022 10:27:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 17F951F45AF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651166861;
        bh=f/YKBB23D0bseW16hv84OHBRhIMmK//gXgwxfifn6wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFHkcLOf+zGzJqMAyknpw1W9Uy7790ipn/B7lvWc+TpS3A8R0HmJfYVV80brlodQn
         LlOc33tIg6LIgDA4KNLWt0/ULYZFRv9Km77eVdUg+GOawujomqVnWdUhZAAHCibRlA
         7jGDAm48/pS9de43lgY4fUZPRR+LDnGTuQ+MrR68A7kVJzpxvBsqKy+IjTrWEg+fUu
         0CuQcLhCztNqOJWQx6qKfxZK8lgsi4XAisTSyyOeU4Vty4gYNho8caBV0GduangYLT
         +dGb05RLZHX3thrDUl4SiQ13KCyRKsG0DxqYRiBhbiwxIHRnlmVtXs3pOaTeJOT8aK
         iJgw52vNTgPqA==
Date:   Thu, 28 Apr 2022 13:27:36 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>, hsinyi@chromium.org
Subject: Re: [PATCH v8 2/2] arm64: dts: Add MediaTek SoC MT8186 dts and
 evaluation board and Makefile
Message-ID: <20220428172736.qlkinujpxjxumsnx@notapiano>
References: <20220428061717.11197-1-allen-kh.cheng@mediatek.com>
 <20220428061717.11197-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428061717.11197-3-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

On Thu, Apr 28, 2022 at 02:17:17PM +0800, Allen-KH Cheng wrote:
> +		scp: scp@10500000 {
> +			compatible = "mediatek,mt8186-scp";
> +			reg = <0 0x10500000 0 0x40000>,
> +			      <0 0x105c0000 0 0x19080>;
> +			reg-names = "sram", "cfg";

The mtk,scp dt-binding should be updated as it currently doesn't allow l1tcm to
be missing. According to comments in the driver cfg is optional as well, so a
patch to the binding making both optional would be great.

Thanks,
Nícolas
