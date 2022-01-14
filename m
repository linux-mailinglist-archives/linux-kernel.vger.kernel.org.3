Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4A48E85F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbiANKfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:35:19 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41128 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233947AbiANKfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:35:18 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20E6h4gD020480;
        Fri, 14 Jan 2022 11:34:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=selector1;
 bh=RIXsykMSfBoDap0KDA7BfOr8gY7UNB4Kwa057e833C4=;
 b=S2LbzhX2bStSasodrbVQLbE1s+WNZk5TlHtTIMuzO2ldJiCsT2MniH03+TLaZSjhPDQX
 BCkB31/VPCOaNt+eVvDPk0DSTY4jRqbwq4zfA4r78cG0yvYuabfygKF811P6w+NzIsN+
 Bh3iG55v/n4oL5IObNkvqIYZ/QKYa50fgAjneh4M3ug+J0V0HY1fI1T9tm0aXM2AMXRQ
 UOhxbbhkEjQEYa8EXfpqyKKcuBjBXvH4KrFq32Nzj+YuGB5eWxPOCNG/sfeEwbplMNAj
 u5ablnglXxqAds98O2SdrQFE+jYqc3kP1i94H2FBAYYh7PA+dGEaEg1GYVvk3g/YTxLS kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dk45ascdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 11:34:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EAA9710003A;
        Fri, 14 Jan 2022 11:34:22 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF556212303;
        Fri, 14 Jan 2022 11:34:22 +0100 (CET)
Received: from gnbcxd0016.gnb.st.com (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 14 Jan
 2022 11:34:22 +0100
Date:   Fri, 14 Jan 2022 11:34:15 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Philippe Cornu <philippe.cornu@foss.st.com>
CC:     Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Christian Konig <christian.koenig@amd.com>, <soc@kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: update drm/stm drm/sti and cec/sti
 maintainers
Message-ID: <20220114103415.GA374310@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>, Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Christian Konig <christian.koenig@amd.com>, soc@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20220113171921.17466-1-philippe.cornu@foss.st.com>
 <20220113171921.17466-3-philippe.cornu@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220113171921.17466-3-philippe.cornu@foss.st.com>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_04,2022-01-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

thanks for the patch.

Reviewed-by: Alain Volmat <alain.volmat@foss.st.com>

Alain

On Thu, Jan 13, 2022 at 06:19:21PM +0100, Philippe Cornu wrote:
> Add Alain as sti maintainer for both drm/sti & cec/sti.
> Add Raphaël as stm maintainer for drm/stm.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@foss.st.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6bea080d0159..708f8c86e4c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6423,6 +6423,7 @@ F:	Documentation/devicetree/bindings/display/rockchip/
>  F:	drivers/gpu/drm/rockchip/
>  
>  DRM DRIVERS FOR STI
> +M:	Alain Volmat <alain.volmat@foss.st.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> @@ -6431,6 +6432,7 @@ F:	drivers/gpu/drm/sti
>  
>  DRM DRIVERS FOR STM
>  M:	Yannick Fertre <yannick.fertre@foss.st.com>
> +M:	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>  M:	Philippe Cornu <philippe.cornu@foss.st.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
> @@ -18152,6 +18154,7 @@ F:	Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
>  F:	sound/soc/sti/
>  
>  STI CEC DRIVER
> +M:	Alain Volmat <alain.volmat@foss.st.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/media/stih-cec.txt
>  F:	drivers/media/cec/platform/sti/
> -- 
> 2.17.1
> 
