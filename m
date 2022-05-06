Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD9851D338
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390050AbiEFIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbiEFIXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:23:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A9665439;
        Fri,  6 May 2022 01:19:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6DEB81F406ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651825162;
        bh=EKku66uCUZdhACj9FDdRR9vSI5fzEhyGSjYJzQuulqs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=brGZxo5j/RPWYugIKdPNHQNpFqi4PYyD2ei3rTUFFBf9H+w5un+k6VfkAb/5ZDycl
         ky8AjIyHHYdC/bPd1JVfE5PpsmTYGgFUmisqumxh0+bRLxvOK2OEGtGkWDIjipsqbv
         cJghLnUwztsXbMwBmgOJb1uVH8Btw57xViLx58u0JyMvHxpLB+i8KZgo3e6aRyKpYF
         1LPf6vlhTxdRXeI4DdoHZbpq5/X5bL8eAbQZoUOuEpX2TUzdjvtA+Fag3/O5V+vEFo
         vEMJkCVX7D+u7KtF/souItZ1HdTDQuVgx50Y401E9StoU0zT/piF0PdN0betlHGBq2
         2ceuvQblhPWMQ==
Message-ID: <7a4e7d71-4460-21f4-35fa-d3b11559785b@collabora.com>
Date:   Fri, 6 May 2022 10:19:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/3] soc: mediatek: devapc: Separate register offsets
 from mtk_devapc_data
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     runyang.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220504115501.3490-1-rex-bc.chen@mediatek.com>
 <20220504115501.3490-3-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220504115501.3490-3-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/05/22 13:55, Rex-BC Chen ha scritto:
> The register offsets is the same between MT6779 and MT8186. To reuse the
> register offsets, we move these register offsets to another structure
> "mtk_devapc_regs_ofs".
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

