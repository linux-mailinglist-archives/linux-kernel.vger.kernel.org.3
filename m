Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0618252C291
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241513AbiERSmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241498AbiERSmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:42:20 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A960E195BEA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:42:18 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IHeIYV031831;
        Wed, 18 May 2022 18:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=JkdAJp6/nFA0fMkh73Q6AHAhW3P+czhEF0OIA1t5HCg=;
 b=Qg2AhnHrd3KBRi0DM+Bb3C5HbTo+NMkyfHHtmg++jWG9ug+/mnlUut0DeIcgWTWtI//2
 HI6OjGG/DUrRPlT32fATsiDynZSEP+I3w0v6l2juXvPIUAPpeADtplpUS+ptlXAG3tFI
 d+t4fePOEIgxlDSGArqM8HgF2nYdi2nUvcC2nqJrCqM0ypC9/4655ZTL2f9YPksE/jl9
 Pk3xAGjSmX8pnhrRgS8KClB67yDFV7hx7UFCHMQdsGNdGQJ/6nj1PWHFv/lgNkyS2s5D
 Y/H7skS6+Wn3n5hPvTuDy+i9B1Wm4vBh0lEx/9u2lMfxgj8ZWjloLXNVjOBm7tCsCmxE fQ== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3g52ynjr3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 18:41:29 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id A42CD57;
        Wed, 18 May 2022 18:41:28 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [10.207.216.251])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id CAE565B;
        Wed, 18 May 2022 18:41:25 +0000 (UTC)
Date:   Wed, 18 May 2022 13:41:25 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] iommu/vt-d: Make intel-iommu.h private
Message-ID: <YoU91f2ncSkJP27T@swahl-home.5wahls.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
X-Proofpoint-GUID: eeDz9k6Fyio9EZLTXEQmcX-SiAr354e5
X-Proofpoint-ORIG-GUID: eeDz9k6Fyio9EZLTXEQmcX-SiAr354e5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 mlxlogscore=648 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180108
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 09:43:15AM +0800, Lu Baolu wrote:
> Hi folks,
> 
> The include/linux/intel-iommu.h should be private to the Intel IOMMU
> driver. Other drivers or components should interact with the IOMMU
> drivers through the kAPIs provided by the iommu core.
> 
> This series cleanups all includes of intel-iommu.h outside of the Intel
> IOMMU driver and move this header from include/linux to
> drivers/iommu/intel/.
> 
> No functional changes intended. Please help to review and suggest.

I went through and examined the changes as well.  These changes make the
robots complaint against my patch go away, which is great by me!

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

-- 
Steve Wahl, Hewlett Packard Enterprise
