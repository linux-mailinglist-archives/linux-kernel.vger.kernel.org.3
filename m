Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133A64CE182
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 01:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiCEA17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 19:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiCEA15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:27:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE7E13296A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 16:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646440029; x=1677976029;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XV+n/NJkcz3/ePkY4gQWF6q/kfO4XcUr63JK3PaF+xk=;
  b=KxVDl1GyIJ5ZaPDZwa64RGe5yjVOwxhQiN9fITqSj7i6T8+EjJRoDUEq
   EwWtUGcH4nQ4XFViE+KfvIWVGaVxMD9DxFXqtUMJxPFre8+KeB2q6mORa
   srYsovnwW8IyeNnQp3vgWeVEeth0YpBZlpx9gpDoXTLdk/CVYrq/vhDGB
   cS2+zhaPt/Mzder+v6aNAn6xA7H6a3cPTUbxrM9ra0uKUZgVUPM92BRIe
   9SzGmpS48nJs955uiNjdDxOvNOtvsAeX1nygrtP/PL0v+qf2Fvwhgb+g3
   /jNtzUJs70eCy77NgSPJyh4rmh3s5mkIGprHNr+tavHtDVOrvbsHlCgU4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="340523163"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="340523163"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 16:27:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="494491485"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 04 Mar 2022 16:27:08 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 16:27:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 4 Mar 2022 16:27:07 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 4 Mar 2022 16:27:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxbIM5EK4UmLf2de+BArjePkEzY92ntTPF8vjuvsQUXNY7y9ULePPIyZxXpQLNioc4q1ScZOJlq74Ik2vjJOrDsPo4WHljo5qqNfdOdbdC7Xots8Ra7bF8nVQIjbCk3hyEFX0Yepc8QJpM5lfss0xXkrvmjxC0/7o46szf5CNmo+6ZMLC1ebjYoEB5TqpsWh5OUnzXgaPVs5BpS4OdNc+iODOgzew5SmIFjvsLv/AAqm9QufLXYmI1W8+/Js6JRtRmtErwfZLE6wEJU/6JO/cXu5W78mMdkbLHeytZ61YAbzwrzEHJiJNin9a1SksMQ0Ke7aZ6KViHyhUM1/g+Pfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/XtZCRhavfl6O2K+KcYkxaFjQNcQwXVoqlMx9+fq4Y=;
 b=Gic/w4juwVJqSVACUGPSitLAuBxhZubmC3nmLV302zzRtqeTjTltN7u9iqm6L31dfJWAllLSaIhd9dGKLiiY5Ox+QUlKEU1ypnuz6N4XAIBdBE1d4uff51tB/psfBPnTUmIjpfpYThZLWrHViZX/+6BiPBYTgiHSlLleACQexPpNeNf7JGStnAO2mxBk4b+jnsq+CVZqFiNtbxBpw3zAeX6SC+bJEQpsXD7soDky1xW4KeTxRgDfZu8mTo3Oqk0kfNyJMWfkj6G+AjuC/47Ud3Iw1tMnvcKNtntGu8/TXT05y3UpISp4Ro/Ysu7rkBqBR0lXCt9OlqGxZ2qCj5gNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BL0PR11MB3010.namprd11.prod.outlook.com (2603:10b6:208:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sat, 5 Mar
 2022 00:27:04 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.017; Sat, 5 Mar 2022
 00:27:04 +0000
Message-ID: <c4088205-a344-5ef8-15e2-9ccc5d1691ea@intel.com>
Date:   Fri, 4 Mar 2022 16:27:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH v3 12/21] x86/resctrl: Calculate bandwidth from the
 previous __mon_event_count() chunks
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-13-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220217182110.7176-13-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0017.namprd14.prod.outlook.com
 (2603:10b6:300:ae::27) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8dc2996-d719-4e9d-c395-08d9fe3edfc2
X-MS-TrafficTypeDiagnostic: BL0PR11MB3010:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR11MB30102CF187EBE954450C84C5F8069@BL0PR11MB3010.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcy+tjLumr4Zou0/hsExrTq/nRJ26dR8gt4Rhryk/rcPLtkQrh+b13MSBXYQxLOQi0XoB8OBc9VYhpmeu+CIPjHaQW7b87aFa2wvyXOPvJmGvFZ5sNrG8+Lkyiw8X3BGbQSeUyJBu2Z6GSoHoafZwizTZh1xz4AqKal/BvwvVauzyJydv0rhBybQVhxoKDvJ9dnWI7syOazd/h/FNV2+4hWJe4VkWFo8C3LsguU54kwogwXexkquzy8V5mxt7aNDAoGZMpIvI7PPXExnv3/sQEgm+qJfO9zclq5/6vY3e4QNOLJFzWZEealQSl4AhLVZ0PL0zWccU3sPcEaEfivJMC0OuO6aG6riYZPIIWNxyzB27zZi45LNdPPjbsw1XKEh4xp4cz2aPB9PeMisonlrloGVd7O9jbfqxe4ksQzhTMomyl2eKLvrKrWXLvuYIbMIqGY06Tf33aDghotXkTKCAmgYpCYRDww/7eaLh4d3NvGsgmPaKTu9Sl7dwi4VhauJPiQstQe+66qaqalMCsciZw0DBDS+pTRHPpIlR3gB3oRxQtDR0Qv/D1R3h5v/FSm9sY7KPG+tGsURYYP/qTkBfalNGkWTcvON63q1lEurwo4+pTxiIDUhsq4J5shT9u70A8qeBMVftCqfJ8oMiyYzgMmuwNwqTRvWL+Yv3LOcQJyJutgTi+5qA6kknKfoC65SpRNqpZw2a0HK9fN3STfjbJ8tKujnB7fr2WfOEtGk9Us=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(66556008)(66946007)(44832011)(2616005)(6512007)(4326008)(316002)(31696002)(5660300002)(8676002)(7416002)(66476007)(8936002)(86362001)(36756003)(53546011)(6506007)(6486002)(38100700002)(6666004)(508600001)(2906002)(83380400001)(26005)(186003)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1pYRGgrNTFvV2hTREx2NWRDZGxiM1YwWUtvUG01Vmx5MklrQmdFazZiUVR3?=
 =?utf-8?B?cjlaYWFkb3JCaUFydG0zR1dnUFB6WFZNUVRKM1VoblY5TTBaQm1PQkRDYU5E?=
 =?utf-8?B?Z0Y4Q3hFRzM2a21tYUZsTjFUeGswdmJLUjNrRVRzWHFVQ3RhZEJzODEwM3VZ?=
 =?utf-8?B?aXBYT0xZM3lFK0JTeGdYQnVxeGdtd29IdnBvdTBxNms4dEdzU1NpekZnYk9B?=
 =?utf-8?B?SE9kanFxeDQrbkIxOHI0UU1acGIrNDZQNU9ZVSt6WlYxTndQT2lrLzJpSE5q?=
 =?utf-8?B?Mi9BRHM2VVpyemFNM0szdjRBYU9TeHN1YWJuSjBHZVJmSW9rVVdPMExjZUc1?=
 =?utf-8?B?NzFWa0NHRmliTDB3dHJCa3d4YnR5TFl1Tmt2RzFleWEvMjRHVkNWc1I4aVBT?=
 =?utf-8?B?NnpmUU0reDB2czVNTjdrVTBScVFadXRmSGJTbFJqdklQcmgrT3VEZVJCVFNW?=
 =?utf-8?B?d2FMcTBtVGk4K0xWWFBsdUk3NHlxWVZxZTJMUHp5WlpyMmgveTNtS3RwYXFJ?=
 =?utf-8?B?NmJabVlZd1R5OE05VFlpMFN0U2FSempuY1BlSjVFUUwwNVFFL0ZmRmJEMllY?=
 =?utf-8?B?VDJseUU4RXJVclNqOTBwTUk2MFpQSW5qUnI5YXNRNUJNV0lHYmpaMUF3Zkh4?=
 =?utf-8?B?QkppUGhVOUxIRnRSc3NjdndlM3o1RklGMVFrSCtNQXJFLzRTblBDRkw3K3FD?=
 =?utf-8?B?Y0tIZTdYQ0pYVGtaNmRyNzZMUFRKSnZia1Bod3IvdzE3Y0kyaW1pN0c1SElC?=
 =?utf-8?B?WCtBM2ZZSE0reG95MjZaams4c0JiY0xidlU4WW1JbURKNVZvcVR5YTFCZ0hV?=
 =?utf-8?B?L0lieEdaTW1SR3ZGZXJGblJ5QmNQZDN3ZlRGV3ZFcktuRkY2N2hBT1BhL29S?=
 =?utf-8?B?cFpJMG8xVWlTeTFkOWphblozRitEZ1ByTFNBWUQzekdvenBQUU5HMzdjbzc1?=
 =?utf-8?B?QXo3YlJwek9lTlZmWU5XcU5GMEFONnpoVDZlM3hZMGM4ZldsVzY1THRqWGhL?=
 =?utf-8?B?eld4UmJvTCtyUlN5enU2VWd6ajZDVGZKTTZtdll1T293NHVoTU9lVjVZSGtE?=
 =?utf-8?B?R0lOdXF5QThKbisrZWhSenJrdlhyT01KOGdPSFYxcUxSc2doRnA5TlFkZ2Nu?=
 =?utf-8?B?U01xUXBzbUpoczQ2MDF4TXE3dWZOeDlhays2OVQzOXdPcEdLdkJSWFY2bWUw?=
 =?utf-8?B?cGlaTVppbmExRnA5N0trVGZVczlBRWZyckU4R0RrdEdJMnZoRThkTDZmMDNI?=
 =?utf-8?B?RTU3SVNNN1dZeThpblYxQkZCQy9Mc09pU0ptOUdoYzBhY0k1RFNEU3hFczB1?=
 =?utf-8?B?UW9Ua3NKRjEvanBKOGsyU0lRQ3gwbEpuZnhKOTM3TU5QdS8vMU9YK1lTZGtz?=
 =?utf-8?B?VmdyaXUvZFhiL0dvamNGMlFxRmpzNEw3ZWV4bFJDY3U4emNHeXNQYzZXY2Zy?=
 =?utf-8?B?VHgxQTJrdkZpTFpINFR1dDI1dDJJNk5nUFV6YmFWaTNaRlZQN3Nmd2JZRmtB?=
 =?utf-8?B?Mks4Mm82RXQvZmllV2YzRkhUSWVUZjF0cGRFTGR1cU5GVzkzL2M2VmpUaE5p?=
 =?utf-8?B?NkQ1ZTVxalF0TVJaK3JOVy9rVmJWY0w1d0VnN0R3N25ZNkxjNk02Y3p2OUhD?=
 =?utf-8?B?b0h2Q29xVitBQnF5UG4xQzZLVFhNK2VRRkwxSHpIZE92Q1BPZ0hRTkN1TzJR?=
 =?utf-8?B?VHFaSG9XSjFFSlVVSE1ycFFpYXlNaWtjb0FZanZOaTJUelQ0aGNiTFNndjEw?=
 =?utf-8?B?UGpRMmlSN0hwM1diaiszTHlzL0xGeU9lNUFOWFZvSUFpNmVTZDVLUXd0N0hK?=
 =?utf-8?B?aHBCWklydzJrVkpOeTFWYk9xNlBBLy9pWVlaeVd1Q3RIaUtsa08ySjR4dDJr?=
 =?utf-8?B?YzJUbFRSOTBDY1V6a09uZ2p0c2xYRitMWVFFNFpYU3k3L0FpSGRzY3JGWjdo?=
 =?utf-8?B?Y29NMHNJUms5ZzV1T2wzMFhpUzRxUDRUdUZRVTRobEdxcTBmWUVEZnYwNVRU?=
 =?utf-8?B?b1dIeTNrVVBFVEloaUpqQVBJYjZtNHBrTnJZNTgxN1J6T0dLcWZiT1pHbFQw?=
 =?utf-8?B?VnlpNDhvV3FNV0tkMmc0SW12TVpiYVVMODBPRmN2Sll4WXp4UFpOWEFGY044?=
 =?utf-8?B?NmZXdERLTXQ3OEV5S3RyYXpNNUVNR2FCZW1UWk5zc0ZLdE53b014aXQ4SEFm?=
 =?utf-8?B?eGNLbTdZak4rWVI1aEdvemxqUUgzRmU4UnBGaWVaSlh4WmlSaXVQa3NPVGNs?=
 =?utf-8?B?WFFLSnhBYjJBemtsbHlJK2xXN1BRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8dc2996-d719-4e9d-c395-08d9fe3edfc2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 00:27:04.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJHD9KZNuq5mcb3WywfGn99oI3jMswiMy56eY6ul1jngDFnhDKzhUZg4JBCulyF5++JNfuIBdTQd+M6kSSxRJDYpdZhRhmiO+J48grEUero=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3010
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/17/2022 10:21 AM, James Morse wrote:
> mbm_bw_count() is only called by the mbm_handle_overflow() worker once a
> second. It reads the hardware register, calculates the bandwidth and
> updates m->prev_bw_msr which is used to hold the previous hardware register
> value.
> 
> Operating directly on hardware register values makes it difficult to make
> this code architecture independent, so that it can be moved to /fs/,
> making the mba_sc feature something resctrl supports with no additional
> support from the architecture.
> Prior to calling mbm_bw_count(), mbm_update() reads from the same hardware
> register using __mon_event_count().
> 
> Change mbm_bw_count() to use the current chunks value most recently saved by
> __mon_event_count(). This removes an extra call to __rmid_read().

> Instead of using m->prev_msr to calculate the number of chunks seen,
> use the rr->val that was updated by __mon_event_count(). This removes a extra
> calls to mbm_overflow_count() and get_corrected_mbm_count().

"removes a extra calls" -> "removes an extra call" ?

__mon_event_count() ends with "rr->val += get_corrected_mbm_count()" and
it is called twice by mbm_update(). The intention in this change is for
mbm_bw_count() to benefit from the rmid read done just before ...
but would using rr->val within mbm_bw_count() not result in it getting
data from both rmid reads due to the increment?

mbm_update() {

	rr.val = 0;

	if (is_mbm_total_enabled()) {
		...
		__mon_event_count() /* rr->val += ... */
	}
	if (is_mbm_local_enabled()) {
		...
		__mon_event_count() /* rr->val += ... */

		if (is_mba_sc(NULL))
			mbm_bw_count(rmid, &rr); /* Use rr-> val */
	}


Should rr.val perhaps be reset before each __mon_event_count() call instead of
just at the beginning of mbm_update()?

> Calculating bandwidth like this means mbm_bw_count() no longer operates
> on hardware register values directly.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Expanded commit message
> 
> Changes since v1:
>  * This patch was rewritten
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  4 ++--
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 24 +++++++++++++++---------
>  2 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 3b9e43ba7590..c50c8911ef59 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -289,7 +289,7 @@ struct rftype {
>   * struct mbm_state - status for each MBM counter in each domain
>   * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
>   * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
> - * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
> + * @prev_bw_chunks: Previous chunks value read when for bandwidth calculation

"value read when for" -> "value read for"?

>   * @prev_bw:	The most recent bandwidth in MBps
>   * @delta_bw:	Difference between the current and previous bandwidth
>   * @delta_comp:	Indicates whether to compute the delta_bw
> @@ -297,7 +297,7 @@ struct rftype {
>  struct mbm_state {
>  	u64	chunks;
>  	u64	prev_msr;
> -	u64	prev_bw_msr;
> +	u64	prev_bw_chunks;
>  	u32	prev_bw;
>  	u32	delta_bw;
>  	bool	delta_comp;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index ac1a2e8998bb..8ae375e29256 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -315,7 +315,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>  
>  	if (rr->first) {
>  		memset(m, 0, sizeof(struct mbm_state));
> -		m->prev_bw_msr = m->prev_msr = tval;
> +		m->prev_msr = tval;
>  		return 0;
>  	}
>  
> @@ -329,27 +329,32 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>  }
>  
>  /*
> + * mbm_bw_count() - Update bw count from values previously read by
> + *		    __mon_event_count().
> + * @rmid:	The rmid used to identify the cached mbm_state.
> + * @rr:		The struct rmid_read populated by __mon_event_count().
> + *
>   * Supporting function to calculate the memory bandwidth
> - * and delta bandwidth in MBps.
> + * and delta bandwidth in MBps. The chunks value previously read by
> + * __mon_event_count() is compared with the chunks value from the previous
> + * invocation. This must be called oncer per second to maintain values in MBps.

"must be called oncer" -> "must be called once"

>   */
>  static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
>  	struct mbm_state *m = &rr->d->mbm_local[rmid];
> -	u64 tval, cur_bw, chunks;
> +	u64 cur_bw, chunks, cur_chunks;
>  
> -	tval = __rmid_read(rmid, rr->evtid);
> -	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
> -		return;
> +	cur_chunks = rr->val;
> +	chunks = cur_chunks - m->prev_bw_chunks;
> +	m->prev_bw_chunks = cur_chunks;
>  
> -	chunks = mbm_overflow_count(m->prev_bw_msr, tval, hw_res->mbm_width);
> -	cur_bw = (get_corrected_mbm_count(rmid, chunks) * hw_res->mon_scale) >> 20;
> +	cur_bw = (chunks * hw_res->mon_scale) >> 20;
>  
>  	if (m->delta_comp)
>  		m->delta_bw = abs(cur_bw - m->prev_bw);
>  	m->delta_comp = false;
>  	m->prev_bw = cur_bw;
> -	m->prev_bw_msr = tval;
>  }
>  
>  /*
> @@ -509,6 +514,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>  	rr.first = false;
>  	rr.r = r;
>  	rr.d = d;
> +	rr.val = 0;
>  
>  	/*
>  	 * This is protected from concurrent reads from user

Reinette
