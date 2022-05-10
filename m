Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47361522482
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiEJTHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242243AbiEJTHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:07:09 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916A995DE7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:07:08 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AJ4gjm012605;
        Tue, 10 May 2022 19:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pps0720;
 bh=mhRPpgk7nWGY4A6HlKhZOSFnmi/jRL/Ly0+izj8z7nE=;
 b=aaZc3yZ8lNcPA4E73g1YxILRVqX2LrzMhD0NdW9qfxANqC+gAj5BGBmYGWtWE8ChO/2e
 VG+Vaf6z2LKVf1mYp3ic8y4/x57XAL13d+8E8AsA+yPnd1o3ZIrlgvr80ZRttYiI2kCc
 k8cm+AFw8vVpstT6VM5s04xdypi2nae4oicptWgvKmLAudS58niBKUDwy34c6aBqEMJs
 wMpVPcSA4y46jCByCq6PyaBbvnIPTtbm1E1nbZAzvxnG29OudrHv/3c75uyT6vrHD+V2
 pYkDwqE0zTiw7sAWtu1UBv+sTmmia3HgBdpSu7zOdytfT6IXJVxqsZvjQWSPn61sqs0W Mw== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fypmkvf42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 19:06:41 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 1393C5E;
        Tue, 10 May 2022 19:06:40 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [10.207.233.204])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 028D04B;
        Tue, 10 May 2022 19:06:37 +0000 (UTC)
Date:   Tue, 10 May 2022 14:06:37 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Rodel, Jorg" <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Will Deacon <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Message-ID: <Ynq3vRhBWZxImPC0@swahl-home.5wahls.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <e2afd89c-b1cf-9fde-4ce2-4be3c1fdaf07@linux.intel.com>
 <BN9PR11MB5276F4D5F8AD33293233B9AB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
 <636a680eb85aded76dd765ba297347ceadc3d1a4.camel@infradead.org>
 <BL1PR11MB5271099D98542F8A3F877D4E8CC59@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YnU+GuPGiFcBXQJg@swahl-home.5wahls.com>
 <BN9PR11MB52769C9F1BD67185A51F16C28CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB52769C9F1BD67185A51F16C28CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Proofpoint-ORIG-GUID: X1gW75lflYtXFEMHNsqGoidFXE8ifggL
X-Proofpoint-GUID: X1gW75lflYtXFEMHNsqGoidFXE8ifggL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_06,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100081
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 01:16:26AM +0000, Tian, Kevin wrote:
> > From: Steve Wahl <steve.wahl@hpe.com>
> > Sent: Friday, May 6, 2022 11:26 PM
> > 
> > On Fri, May 06, 2022 at 08:12:11AM +0000, Tian, Kevin wrote:
> > > > From: David Woodhouse <dwmw2@infradead.org>
> > > > Sent: Friday, May 6, 2022 3:17 PM
> > > >
> > > > On Fri, 2022-05-06 at 06:49 +0000, Tian, Kevin wrote:
> > > > > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > > > >
> > > > > > > --- a/include/linux/dmar.h
> > > > > > > +++ b/include/linux/dmar.h
> > > > > > > @@ -19,7 +19,7 @@
> > > > > > >   struct acpi_dmar_header;
> > > > > > >
> > > > > > >   #ifdef	CONFIG_X86
> > > > > > > -# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> > > > > > > +# define	DMAR_UNITS_SUPPORTED	640
> > > > > > >   #else
> > > > > > >   # define	DMAR_UNITS_SUPPORTED	64
> > > > > > >   #endif
> > > > >
> > > > > ... is it necessary to permanently do 10x increase which wastes memory
> > > > > on most platforms which won't have such need.
> > > >
> > > > I was just looking at that. It mostly adds about 3½ KiB to each struct
> > > > dmar_domain.
> > > >
> > > > I think the only actual static array is the dmar_seq_ids bitmap which
> > > > grows to 640 *bits* which is fairly negligible, and the main growth is
> > > > that it adds about 3½ KiB to each struct dmar_domain for the
> > > > iommu_refcnt[] and iommu_did[] arrays.
> > >
> > > Thanks for the quick experiment! though the added material is
> > > negligible it's cleaner to me if having a way to configure it as
> > > discussed below.
> > >
> > > >
> > > > > Does it make more sense to have a configurable approach similar to
> > > > > CONFIG_NR_CPUS? or even better can we just replace those static
> > > > > arrays with dynamic allocation so removing this restriction
> > > > > completely?
> > > >
> > > > Hotplug makes that fun, but I suppose you only need to grow the array
> > > > in a given struct dmar_domain if you actually add a device to it that's
> > > > behind a newly added IOMMU. I don't know if the complexity of making it
> > > > fully dynamic is worth it though. We could make it a config option,
> > > > and/or a command line option (perhaps automatically derived from
> > > > CONFIG_NR_CPUS).
> > >
> > > either config option or command line option is OK to me. Probably
> > > the former is simpler given no need to dynamically expand the
> > > static array. btw though deriving from CONFIG_NR_CPUS could work
> > > in this case it is unclear why tying the two together is necessary in
> > > concept, e.g. is there guarantee that the number of IOMMUs must
> > > be smaller than the number of CPUs in a platform?
> > >
> > > >
> > > > If it wasn't for hotplug, I think we'd know the right number by the
> > > > time we actually need it anyway, wouldn't we? Can we have a heuristic
> > > > for how many DMAR units are likely to be hotplugged? Is it as simple as
> > > > the ratio of present to not-yet-present CPUs in MADT?
> > >
> > > Probably. But I don't have enough knowledge on DMAR hotplug to
> > > judge (e.g. whether it's strictly tied to CPU hotplug and if yes whether
> > > there could be multiple IOMMUs hotplugged together with a CPU
> > > socket)...
> > >
> > > Thanks
> > > Kevin
> > 
> > Would anyone be more comfortable if we only increase the limit where
> > MAXSMP is set?
> > 
> > i.e.
> > 
> > #if defined(CONFIG_X86) && defined(CONFIG_MAXSMP)
> > # define	DMAR_UNITS_SUPPORTED	640
> > #elif defined(CONFIG_X86)
> > # define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> > #else
> > # define	DMAR_UNITS_SUPPORTED	64
> > #endif
> > 
> > Thank you all for your time looking at this.
> > 
> 
> This works for your own configuration but it's unclear whether other
> MAXSMP platforms have the exact same requirements (different
> number of sockets, different ratio of #iommus/#sockets, etc.). In any
> case since we are at it having a generic way to extend it makes more
> sense to me.

So, to be clear, what you would like to see would be Kconfig entries
to create a config option, say "NR_DMARS", set up so the default is:

     MAXSMP?  640
     X86_64?  128
     X86_32?  64
     other    64

And DMAR_UNITS_SUPPORTED gets removed, and everywhere it was used we
use CONFIG_NR_DMARS in its place?

I can give that a shot but wanted to confirm this is what you'd want
first.

Thanks,

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise
