Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454874C3F47
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiBYHsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbiBYHsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:48:23 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BEF24FA3A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:47:52 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4TuLx026634;
        Fri, 25 Feb 2022 07:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=AcatjmiBHbccUpcc7TaHOoYhFJm1bkKhJ0c85l+DH3I=;
 b=DaAZEPh3Krjhza8G5X7WYKd5mvXv/agogDXHR/e8pnvGM85o8WzwvZCLfwY+HDfXnFRy
 Y8ds9a4ND6yQoHQ60ARg2PpDRVDRNT7Kmt7U+ONrsJ6Ruy9C+ng7fDmslFkkigRGANA1
 cq4kplfsFDsR8xgHF6aunf5++BnasogwjHciKgpBJVmJ1stDTZjcEsd1S6cAthuZ5g9x
 O80stGMdIEXFAMAXqgxU4pin3FBgrN/iT5FfWgKvzjvmvHeGPj7mipvxxjpk9pH+LYpS
 6CMaxXKTERy4SFazBOQIg3dyPekIWG7BEy5NRhKo2bszG6DYbO//VH+e5bwpYOCsJ5wg wg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edwkf6a25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 07:47:27 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21P7iwws003036;
        Fri, 25 Feb 2022 07:47:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3eaqtjpv2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 07:47:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21P7lLbu35455288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 07:47:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 250B952057;
        Fri, 25 Feb 2022 07:47:21 +0000 (GMT)
Received: from [9.43.16.34] (unknown [9.43.16.34])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9BFE152051;
        Fri, 25 Feb 2022 07:47:16 +0000 (GMT)
Message-ID: <125761cdabbfeaf6615e67d087ec113408f8eb7e.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/4] Add perf interface to expose nvdimm
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
To:     kajoljain <kjain@linux.ibm.com>,
        Nageswara Sastry <rnsastry@linux.ibm.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com
Cc:     santosh@fossix.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, vaibhav@linux.ibm.com,
        tglx@linutronix.de
Date:   Fri, 25 Feb 2022 13:17:15 +0530
In-Reply-To: <ea6bc468-c7ae-c844-5111-8f0dc3207f89@linux.ibm.com>
References: <20220217163357.276036-1-kjain@linux.ibm.com>
         <ddf18609-84ad-e263-7dff-7b2cc68557ef@linux.ibm.com>
         <ea6bc468-c7ae-c844-5111-8f0dc3207f89@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KIO23H0IT1eV-_hrr8t5UPG0zJq5phzF
X-Proofpoint-ORIG-GUID: KIO23H0IT1eV-_hrr8t5UPG0zJq5phzF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_05,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-25 at 12:08 +0530, kajoljain wrote:
> 
> 
> On 2/25/22 11:25, Nageswara Sastry wrote:
> > 
> > 
> > On 17/02/22 10:03 pm, Kajol Jain wrote:
> > > 
....
> > > 
> > > Changelog
> > 
> > Tested these patches with the automated tests at
> > avocado-misc-tests/perf/perf_nmem.py
> > URL:
> > https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/perf/perf_nmem.py
> > 
> > 
> > 1. On the system where target id and online id were different then
> > not
> > seeing value in 'cpumask' and those tests failed.
> > 
> > Example:
> > Log from dmesg
> > ...
> > papr_scm ibm,persistent-memory:ibm,pmemory@44100003: Region
> > registered
> > with target node 1 and online node 0
> > ...
> 
> Hi Nageswara Sastry,
>        Thanks for testing the patch set. Yes you right, incase target
> node id and online node id is different, it can happen when target
> node is not online and hence can cause this issue, thanks for
> pointing
> it.
> 
> Function dev_to_node will return node id for a given nvdimm device
> which
> can be offline in some scenarios. We should use numa node id return
> by
> numa_map_to_online_node function in that scenario. This function
> incase
> given node is offline, it will lookup for next closest online node
> and
> return that nodeid.
> 
> Can you try with below change and see, if you are still getting this
> issue. Please let me know.
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c
> b/arch/powerpc/platforms/pseries/papr_scm.c
> index bdf2620db461..4dd513d7c029 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -536,7 +536,7 @@ static void papr_scm_pmu_register(struct
> papr_scm_priv *p)
>                                 PERF_PMU_CAP_NO_EXCLUDE;
> 
>         /*updating the cpumask variable */
> -       nodeid = dev_to_node(&p->pdev->dev);
> +       nodeid = numa_map_to_online_node(dev_to_node(&p->pdev->dev));
>         nd_pmu->arch_cpumask = *cpumask_of_node(nodeid);
> 
> > 

Can you use p->region->numa_node? 

-aneesh


