Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA46851DBEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442825AbiEFPac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbiEFPaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:30:30 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14746D187
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:26:47 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2467xT2w002715;
        Fri, 6 May 2022 15:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pps0720;
 bh=j3HGD5V4kWpzXaMKyVHDsHe8vDopec8EpWmrCUlBo/Q=;
 b=kmdrLURnIfYdzD07W4rfqh2pra/lPUr13nK2uzEixModpgW1IAh4u0wQR+xm1DR1ZGLz
 L6jNQzXqIAW0AlcMcrDU3uzbLbTCXtXgeN9tJm9wTjj8yRCyQddU80u7ElJ13VaYIgYY
 E73xFZRaWJfIVdVUMOoblvjoWArs7UhEAd162IdbxjytRuuzPql1Z5MmL1LWKEJbwAhi
 +CjCQVr0WZubJOSweZHAa5krJBfJIt0qoVyPT6zoFFFrv7guSUhyUoaRixVTShcV+Ttj
 jiW3AcRO2GQCRjAE0ku3SltxIdMosnOFrPDLU/cUq3q77AdLxYwmaK8Go5hL9nWtFMMD vQ== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fvyrykfpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 15:26:21 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 444F851;
        Fri,  6 May 2022 15:26:20 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [10.207.210.170])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id D7F8A49;
        Fri,  6 May 2022 15:26:18 +0000 (UTC)
Date:   Fri, 6 May 2022 10:26:18 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        "Rodel, Jorg" <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Will Deacon <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Message-ID: <YnU+GuPGiFcBXQJg@swahl-home.5wahls.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <e2afd89c-b1cf-9fde-4ce2-4be3c1fdaf07@linux.intel.com>
 <BN9PR11MB5276F4D5F8AD33293233B9AB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
 <636a680eb85aded76dd765ba297347ceadc3d1a4.camel@infradead.org>
 <BL1PR11MB5271099D98542F8A3F877D4E8CC59@BL1PR11MB5271.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR11MB5271099D98542F8A3F877D4E8CC59@BL1PR11MB5271.namprd11.prod.outlook.com>
X-Proofpoint-GUID: c-yCiTy8aQYYTm_dey9dRCQuik5rAPEI
X-Proofpoint-ORIG-GUID: c-yCiTy8aQYYTm_dey9dRCQuik5rAPEI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_04,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060082
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 08:12:11AM +0000, Tian, Kevin wrote:
> > From: David Woodhouse <dwmw2@infradead.org>
> > Sent: Friday, May 6, 2022 3:17 PM
> > 
> > On Fri, 2022-05-06 at 06:49 +0000, Tian, Kevin wrote:
> > > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > >
> > > > > --- a/include/linux/dmar.h
> > > > > +++ b/include/linux/dmar.h
> > > > > @@ -19,7 +19,7 @@
> > > > >   struct acpi_dmar_header;
> > > > >
> > > > >   #ifdef	CONFIG_X86
> > > > > -# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> > > > > +# define	DMAR_UNITS_SUPPORTED	640
> > > > >   #else
> > > > >   # define	DMAR_UNITS_SUPPORTED	64
> > > > >   #endif
> > >
> > > ... is it necessary to permanently do 10x increase which wastes memory
> > > on most platforms which won't have such need.
> > 
> > I was just looking at that. It mostly adds about 3½ KiB to each struct
> > dmar_domain.
> > 
> > I think the only actual static array is the dmar_seq_ids bitmap which
> > grows to 640 *bits* which is fairly negligible, and the main growth is
> > that it adds about 3½ KiB to each struct dmar_domain for the
> > iommu_refcnt[] and iommu_did[] arrays.
> 
> Thanks for the quick experiment! though the added material is
> negligible it's cleaner to me if having a way to configure it as
> discussed below.
> 
> > 
> > > Does it make more sense to have a configurable approach similar to
> > > CONFIG_NR_CPUS? or even better can we just replace those static
> > > arrays with dynamic allocation so removing this restriction
> > > completely?
> > 
> > Hotplug makes that fun, but I suppose you only need to grow the array
> > in a given struct dmar_domain if you actually add a device to it that's
> > behind a newly added IOMMU. I don't know if the complexity of making it
> > fully dynamic is worth it though. We could make it a config option,
> > and/or a command line option (perhaps automatically derived from
> > CONFIG_NR_CPUS).
> 
> either config option or command line option is OK to me. Probably
> the former is simpler given no need to dynamically expand the
> static array. btw though deriving from CONFIG_NR_CPUS could work 
> in this case it is unclear why tying the two together is necessary in
> concept, e.g. is there guarantee that the number of IOMMUs must
> be smaller than the number of CPUs in a platform?
> 
> > 
> > If it wasn't for hotplug, I think we'd know the right number by the
> > time we actually need it anyway, wouldn't we? Can we have a heuristic
> > for how many DMAR units are likely to be hotplugged? Is it as simple as
> > the ratio of present to not-yet-present CPUs in MADT?
> 
> Probably. But I don't have enough knowledge on DMAR hotplug to
> judge (e.g. whether it's strictly tied to CPU hotplug and if yes whether
> there could be multiple IOMMUs hotplugged together with a CPU
> socket)...
> 
> Thanks
> Kevin

Would anyone be more comfortable if we only increase the limit where
MAXSMP is set?

i.e.

#if defined(CONFIG_X86) && defined(CONFIG_MAXSMP)
# define	DMAR_UNITS_SUPPORTED	640
#elif defined(CONFIG_X86)
# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
#else
# define	DMAR_UNITS_SUPPORTED	64
#endif

Thank you all for your time looking at this.

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
