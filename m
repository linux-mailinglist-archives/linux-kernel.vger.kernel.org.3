Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBB555E38A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344539AbiF1Mox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240118AbiF1Mov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:44:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477B419C17;
        Tue, 28 Jun 2022 05:44:51 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SCOqbr017601;
        Tue, 28 Jun 2022 12:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=P3twaWHhDTd77mVpF/4CwpTAPR0IiybHjJNeSDkRcL0=;
 b=YwrWAEqSsTmlqynz7lKcfShqsKBIFgU9CMueffzw0g3d3QFZbrujWziXJwmMcte0tS3s
 PomybUJhf2QQKm9wsQQKOSu13v/4Fik9EiUbSv90l6Q+YIRiINfn/iEzkjfEIz3Xs22Z
 yOg83164CET4v2Ary85VNBelO6NSMqcrXslYCVGINCpZGLJ3/dOELlavoZzAx7cR9SUy
 664wqGPZIoQjgFPFbIygtKsHYudwhnfRwpQQ4rsbx67zJCI6qyfZl9mjD3YSN+uRbb9Y
 sXJP1lHQN5bldDX18PznxAH5Kj+2q7x58i9NLF66hfLvuPDBXEv5YwhVWix+EMkLtbrK Jw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h00j82jgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 12:44:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SCavjf020511;
        Tue, 28 Jun 2022 12:44:45 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3gwt08vuhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 12:44:45 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SCiggb13042154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 12:44:42 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BFE35204F;
        Tue, 28 Jun 2022 12:44:42 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.7.238])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 8D4B05204E;
        Tue, 28 Jun 2022 12:44:41 +0000 (GMT)
Date:   Tue, 28 Jun 2022 14:44:40 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, jwi@linux.ibm.com, bblock@linux.ibm.com,
        davem@davemloft.net, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com
Subject: Re: [PATCH] s390/qdio: Fix spelling mistake
Message-ID: <Yrr3uGLBIm8KLiLN@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220623060543.12870-1-jiaming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623060543.12870-1-jiaming@nfschina.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p5I7pTmnw_MLQL_-Hj5SgjsTUXCH1NHu
X-Proofpoint-ORIG-GUID: p5I7pTmnw_MLQL_-Hj5SgjsTUXCH1NHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxlogscore=871
 clxscore=1011 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:05:43PM +0800, Zhang Jiaming wrote:
> Change 'defineable' to 'definable'.
> Change 'paramater' to 'parameter'.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  arch/s390/include/asm/qdio.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/qdio.h b/arch/s390/include/asm/qdio.h
> index 54ae2dc65e3b..2f983e0b95e0 100644
> --- a/arch/s390/include/asm/qdio.h
> +++ b/arch/s390/include/asm/qdio.h
> @@ -133,9 +133,9 @@ struct slibe {
>   * @sb_count: number of storage blocks
>   * @sba: storage block element addresses
>   * @dcount: size of storage block elements
> - * @user0: user defineable value
> - * @res4: reserved paramater
> - * @user1: user defineable value
> + * @user0: user definable value
> + * @res4: reserved parameter
> + * @user1: user definable value
>   */
>  struct qaob {
>  	u64 res0[6];

Applied, thanks!
