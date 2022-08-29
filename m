Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2715A5010
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiH2PTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiH2PTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:19:35 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE52085AB3;
        Mon, 29 Aug 2022 08:19:34 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TF2fsC030426;
        Mon, 29 Aug 2022 15:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pps0720; bh=oJZ8Pnogvl2PqjImYIZJUg0Yb1Tp7C+OILy5IpO3q1Q=;
 b=Jtj7XNQ8UKZzT4qqNpKZHwJAcfyjM1bfJJvM9K6kk5qPBNa/hQh1tRK2j+jv3mjp21Le
 8JxmxA1y+L4GMg6yhr98SJPhi6F8TNDm0e11gqzEYv0XtGry8maRvmDaFl1iZ1ki2Cl7
 Slb3hxgwI0wfBuGBGc7qrnQTJxTag0Uxizhk8udpASJ/jBMT6iAQtml6s6m644zaqmQd
 we6AURZMEsZA5bi50IOA+hsdz06HpANHJcgX7ejxxBkpMnK9udkANNJNrn1DDQPZ8Ywi
 A3zAp9WEVG/7dxqc14eNUMh5CwOZYt7kmSNb7AKx2p+lMoLvnNoVl4+EEVi34A4/fov0 ZQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j8yj6gbpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 15:19:16 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 3CEE5D286;
        Mon, 29 Aug 2022 15:19:16 +0000 (UTC)
Received: from perchik (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 830DB8080ED;
        Mon, 29 Aug 2022 15:19:15 +0000 (UTC)
Date:   Mon, 29 Aug 2022 09:19:13 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] watchdog/hpwdt: Enable hpwdt for ARM64 platforms
Message-ID: <20220828223508.GG30332@perchik>
Reply-To: Jerry.Hoemann@hpe.com
References: <20220820202821.1263837-1-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820202821.1263837-1-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-ORIG-GUID: hMBgF01IZHMfZWHYSviH0oTtGQq3p6wX
X-Proofpoint-GUID: hMBgF01IZHMfZWHYSviH0oTtGQq3p6wX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 mlxscore=0 spamscore=0 mlxlogscore=896 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 02:28:19PM -0600, Jerry Hoemann wrote:
> Enable hpwdt for the rl300, an ARM64 based platform.
> 

Guenter,

Did you have any questions/comments on version 2 of the patch series?

Thanks

Jerry

> 
> Patch 1: watchdog/hpwdt.c: Include nmi.h only if CONFIG_HPWDT_NMI_DECODING
> 
> ARM64 does not support NMI and does not have <asm/nmi.h>.  Include
> nmi.h only if CONFIG_HPWDT_NMI_DECODING is defined.
> 
> Patch 2: watchdog/Kconfig:  Allow hpwdt.c to be built for ARM64.
> 
> Allow hpwdt.c to be built for (ARM64 || X86) as this part of hwpdt doesn't
> use NMI.
> 
> Make HPWDT_NMI_DECODING dependent upon X86 as NMI handlers are specific
> to X86 platforms.
> 
> 
> == Changes for v2 ==
> Update patch documentation.
> 
> 
> 
> 
> Jerry Hoemann (2):
>   watchdog/hpwdt: Include nmi.h only if CONFIG_HPWDT_NMI_DECODING
>   watchdog: Enable HP_WATCHDOG for ARM64 systems.
> 
>  drivers/watchdog/Kconfig | 4 ++--
>  drivers/watchdog/hpwdt.c | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> -- 
> 2.37.1

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
