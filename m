Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6874A4061
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358280AbiAaKmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:42:46 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58138 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358150AbiAaKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:42:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8E6911F4311D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643625763;
        bh=VDCXS99DUqPI4JTZi8sOBTfPcdansr4DXqBbifuXOXI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T7gW8MflY5Yw4jDPpLHRCD0H+jmD/K1Ftxf57efP1GKkaUZ5mFu5iTqM9cjkuRTz9
         gG3syNyUosHelXFFJUc+PcCJAt9++4QN5wQ/4FKaStzlQSQ50cFMvvT9WqpPh+JmOw
         oiENANtFnUx79DeEfqX0SwWTdYH4ARxsuHvxYixEzTpq1qs94EbKsq8udiK2aMtLYZ
         GTuoXFF52h9TYE3w2OvHwF7a3zjw9iRC0e+Yp1Zjg2wSCDJ40+LG8sxGPkxYvxpmvF
         5zkdcWchc10xQrSMLSy/XSB50ZHtoOtTlBvFvcQ173i+7pZkYBsUDj1nXbn2UxFJU4
         9xBoosZdO8Wdw==
Message-ID: <3d9dae30-5cde-9fc1-6705-cb5d6b9f1733@collabora.com>
Date:   Mon, 31 Jan 2022 11:42:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v22 3/7] soc: mediatek: SVS: introduce MTK SVS engine
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20220127033956.24585-1-roger.lu@mediatek.com>
 <20220127033956.24585-4-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220127033956.24585-4-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/01/22 04:39, Roger Lu ha scritto:
> The Smart Voltage Scaling(SVS) engine is a piece of hardware
> which calculates suitable SVS bank voltages to OPP voltage table.
> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> when receiving OPP_EVENT_ADJUST_VOLTAGE.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
