Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A3B4D7F50
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiCNKAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238166AbiCNKAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:00:46 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5691013FA9;
        Mon, 14 Mar 2022 02:59:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22E9rqMQ108791;
        Mon, 14 Mar 2022 04:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647251632;
        bh=sXDP6FRE9AaNqzed1m1RfsUHilWi4nFVgOEPlOZhFcM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=p2YmpfJixwk6rzSKyMZ4uABJJHWukEKF7M5iRHHyWqZUBHKDsueKxief1uzzPTFXy
         lKoRq2MGJsDECgBzvNq2JxICfK+aXBP95nCOHBh7wYgRIfRpJw8iKPtm9wdIozfhru
         4EgnIcu1MCmR/mM5CupYjrBLf9bjksc/ISOUfyjc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22E9rqGZ052177
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Mar 2022 04:53:52 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 14
 Mar 2022 04:53:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 14 Mar 2022 04:53:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22E9rp8V090706;
        Mon, 14 Mar 2022 04:53:51 -0500
Date:   Mon, 14 Mar 2022 15:23:50 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Zhou Qingyang <zhou1615@umn.edu>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH 61/64] media: platform: rename ti-vpe/ to ti/vpe/
Message-ID: <20220314095350.mbvjs7alqoz4vvml@ti.com>
References: <cover.1647242578.git.mchehab@kernel.org>
 <fecdb3d1e4fffbb5c3e0003a7d403ef9669ca026.1647242579.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fecdb3d1e4fffbb5c3e0003a7d403ef9669ca026.1647242579.git.mchehab@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 14/03/22 08:55AM, Mauro Carvalho Chehab wrote:
> As the end goal is to have platform drivers split by vendor,
> rename ti-vpe/ to ti/vpe/.

I submitted a patch to do something similar [0]. I think it is a better 
one because there are actually 2 separate IP drivers here: CAL and VPE. 
My patch puts them both in their own directories, and a later patch 
introduces a 3rd driver, j721e-csi2rx.

So I would like to see my patch's directory structure being used.

Nacked-by: Pratyush Yadav <p.yadav@ti.com>

[0] https://patchwork.linuxtv.org/project/linux-media/patch/20220121142904.4091481-11-p.yadav@ti.com/

> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
