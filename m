Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8D553A57
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353259AbiFUTTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353270AbiFUTT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:19:29 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8062E6B7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:18:46 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LHcnrn026833;
        Tue, 21 Jun 2022 19:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=qs3PCzipYTgCGNDcxZz3wdl1JoNZIFh36ePeUX5Lz5E=;
 b=CWNTQT1Q4GVDNzuAgVVmbmD6Xv6Q5qaDIxxHMn4IG/iwFZVB3VhYoO0Xspe2wNQV/f2W
 pjwjFGHp1tw48/dciOCuq1LM33hJnaJW2NUibv2buxz/y55rY+jO4h5BBbRt2eRChtmY
 V5LSxivix9X1yNU7pfgdaPswREbq0Q5n2/CXjG0vfOG5EGhVii1apM+3gm2VDELUNARO
 x2WXmJ4mZMQaop3ORYWmuCrBANmTDMgi2euXkRT5VxX92fALGI3aHoyZ+vCVMWHmRGML
 e906D81O6Cjk3Hv8KZLsa56TozK1DQfHFQCyBFZHnB5v0ryPzlqHR+bczBBqPjCEZNLt 6A== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3gu4ne0p09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 19:18:38 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id BF1408058CD;
        Tue, 21 Jun 2022 19:18:36 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id AFD04808A2D;
        Tue, 21 Jun 2022 19:18:35 +0000 (UTC)
Date:   Tue, 21 Jun 2022 14:18:33 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     dimitri.sivanich@hpe.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: sgi-gru: grukservices: drop unexpected word "the"
 in the comments
Message-ID: <20220621191833.GA31015@hpe.com>
References: <20220621123203.118488-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621123203.118488-1-jiangjian@cdjrlc.com>
X-Proofpoint-GUID: SIkKl7CGU4fE-yuDlhPezNFNyEII43B6
X-Proofpoint-ORIG-GUID: SIkKl7CGU4fE-yuDlhPezNFNyEII43B6
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_08,2022-06-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210078
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Dimitri Sivanich <sivanich@hpe.com>

On Tue, Jun 21, 2022 at 08:32:03PM +0800, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> file: drivers/misc/sgi-gru/grukservices.c
> line: 39
>  * reserved whenever the the kernel context for the blade is loaded. Note
> changed to
>  * reserved whenever the kernel context for the blade is loaded. Note
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/misc/sgi-gru/grukservices.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
> index 19dbdad8ad8a..fa1f5a632e7f 100644
> --- a/drivers/misc/sgi-gru/grukservices.c
> +++ b/drivers/misc/sgi-gru/grukservices.c
> @@ -36,7 +36,7 @@
>   * kernel/user requirements.
>   *
>   * Blade percpu resources reserved for kernel use. These resources are
> - * reserved whenever the the kernel context for the blade is loaded. Note
> + * reserved whenever the kernel context for the blade is loaded. Note
>   * that the kernel context is not guaranteed to be always available. It is
>   * loaded on demand & can be stolen by a user if the user demand exceeds the
>   * kernel demand. The kernel can always reload the kernel context but
> -- 
> 2.17.1
