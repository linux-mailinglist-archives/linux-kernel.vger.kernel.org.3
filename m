Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09748DCD2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiAMRUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:20:42 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52271 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231493AbiAMRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:20:42 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20DCZAsk024268;
        Thu, 13 Jan 2022 18:20:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=selector1;
 bh=aXxo7+n1UdqA+CufFuU2xisAC4iUYIAOyjkRa57TNqs=;
 b=6gKrEgO2jIIWOJuf6loGN9ovQSZuVG8XWpBdBVt01lQ5EGU5IzwapltboXUg+K2oFzRg
 xdkM0rUWwb9545hVqjvIsieQ8I+5osKHW+ZafqhLF5/LCG/K2pg8K6nOsk76cz1lNh4F
 o9b+emqBxV820hFyf0bJEBfJykuyoOIdY/io9/XadBvVpWOIkEBhxv3gDgXVgCo4hwVf
 JJmSBerES7VU+m+xJZrzjCzRPX5OcQ2FC86iQCX5YzWTuZgF5m5F4sBv3qNBhe8gC7gm
 Mkp5iSTnwe+Y668xM1kMEyTSEcMk3EmFoJwhdbPeAcuHF6G3IWrqR8OMX5bN018F2tuE BA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3djfywtwjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 18:20:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4F3BA10002A;
        Thu, 13 Jan 2022 18:20:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 336862194F9;
        Thu, 13 Jan 2022 18:20:13 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 13 Jan 2022 18:20:12
 +0100
From:   Philippe Cornu <philippe.cornu@foss.st.com>
To:     Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Christian Konig <christian.koenig@amd.com>, <soc@kernel.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linaro-mm-sig@lists.linaro.org>
Subject: [PATCH 0/2] MAINTAINERS: update various stm & sti maintainer names
Date:   Thu, 13 Jan 2022 18:19:19 +0100
Message-ID: <20220113171921.17466-1-philippe.cornu@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_08,2022-01-13_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short serie contains the maintainer status update sent recently by
Benjamin Gaignard (see [1] for details) and add new maintainers for
various stm & sti files.

[1] https://lore.kernel.org/lkml/20210706163033.795805-1-benjamin.gaignard@collabora.com/


Benjamin Gaignard (1):
  MAINTAINERS: Update Benjamin Gaignard maintainer status

Philippe Cornu (1):
  MAINTAINERS: update drm/stm drm/sti and cec/sti maintainers

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1

