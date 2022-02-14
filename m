Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C64B55FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356324AbiBNQVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:21:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356296AbiBNQUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:20:44 -0500
X-Greylist: delayed 1390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 08:20:36 PST
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D1942EE7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:20:36 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21EFuV8X020516;
        Mon, 14 Feb 2022 15:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=P++DMPCoLYeSHVVEkYGtT1XsH/0G6lrbTxQxRb5m1lM=;
 b=Mu5uAhGJsIb1XoS0DqT65OJI+V90s9tMan0lAcMloYeeDXEQ4vjGiReG/21ZTrQIhkhT
 n4PGWs5O790Ra/WvNnXjC1xbIdweIl4Y8+XcZnwdX36oeDlmh7iz/2p/EXd7uzMGyws+
 K2AUp+PhGQEGVUFSDwewINoyziyeoCYhlmYOQDsuu1UL4Jg8xm6X8VeCwa578xdmeNHp
 n/3K0VqSsgfGMNqA2k2x2izWcd03WREPn7u2TVixkyDfZ0V1AkQXJbsd178wTGnRxnyT
 v5WKlfqC+Hlr8aCG6H0lCOfcXG3n0Wjf1/+lXqXTIbH1SiCzDyykSS+xh2lqUzM77egx 0Q== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3e7kkrup4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 15:57:12 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 95DCC82;
        Mon, 14 Feb 2022 15:57:11 +0000 (UTC)
Received: from hpe.com (unknown [10.207.195.135])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 029D93B;
        Mon, 14 Feb 2022 15:57:09 +0000 (UTC)
Date:   Mon, 14 Feb 2022 09:57:09 -0600
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>, linux-kernel@vger.kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] misc: sgi-gru: Don't cast parameter in bit
 operations
Message-ID: <20220214155709.GA3858@hpe.com>
References: <20220214153958.9721-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214153958.9721-1-andriy.shevchenko@linux.intel.com>
X-Proofpoint-GUID: Kw-w50yEarRKtWNI7JFKQJIVTpsUiG3R
X-Proofpoint-ORIG-GUID: Kw-w50yEarRKtWNI7JFKQJIVTpsUiG3R
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202140097
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Dimitri Sivanich <sivanich@hpe.com>

On Mon, Feb 14, 2022 at 05:39:58PM +0200, Andy Shevchenko wrote:
> While in this particular case (*) it would not be an issue,
> the pattern itself is bad and error prone in case somebody
> blindly copies to their code.
> 
> Don't cast parameter to unsigned long pointer in the bit
> operations. Note, new compilers might warn on this line for
> potential outbound access.
> 
> *) it seems a dead code, so remove it all for good
> 
> Fixes: 13d19498b044 ("GRU Driver: driver internal header files")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/misc/sgi-gru/grutables.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
> index e4c067c61251..5efc869fe59a 100644
> --- a/drivers/misc/sgi-gru/grutables.h
> +++ b/drivers/misc/sgi-gru/grutables.h
> @@ -530,12 +530,6 @@ struct gru_blade_state {
>  		for ((i) = (k)*GRU_CBR_AU_SIZE;				\
>  				(i) < ((k) + 1) * GRU_CBR_AU_SIZE; (i)++)
>  
> -/* Scan each DSR in a DSR bitmap. Note: multiple DSRs in an allocation unit */
> -#define for_each_dsr_in_allocation_map(i, map, k)			\
> -	for_each_set_bit((k), (const unsigned long *)(map), GRU_DSR_AU)	\
> -		for ((i) = (k) * GRU_DSR_AU_CL;				\
> -				(i) < ((k) + 1) * GRU_DSR_AU_CL; (i)++)
> -
>  #define gseg_physical_address(gru, ctxnum)				\
>  		((gru)->gs_gru_base_paddr + ctxnum * GRU_GSEG_STRIDE)
>  #define gseg_virtual_address(gru, ctxnum)				\
> -- 
> 2.34.1
