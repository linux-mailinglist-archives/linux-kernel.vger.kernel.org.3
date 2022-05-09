Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD04C51F781
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiEII5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbiEII3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:29:07 -0400
X-Greylist: delayed 124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 01:25:14 PDT
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCE71A3A4
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1652084714;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=O6aDSZMd6MOZ6SA5SLHLDLM/We7AU7S5b8oZBc068kw=;
  b=TTVfmVRJVVq2pEd8jLViGNo9ktfxwCxemYSRmwrn/CJQKRnHR3L2dVc4
   kZU7mz8qCPyQ+obFmRI2NNBvBl1nslbFgceMQ56p0CRLl2lZtpZaA/jWs
   smKXBbCP2OMGhZ8xP4Ff+e5eXfDSgXcDBS3S2Wj0wJHdWJ8MXYQXfNVUB
   M=;
X-IronPort-RemoteIP: 104.47.58.168
X-IronPort-MID: 70253922
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:LwkdOqo28khlQVplpcDx2s+vKnleBmL+ZBIvgKrLsJaIsI4StFCzt
 garIBnUbK7ZNzT2c4h/YNi2/UhU6p7XndNnSVdkripmEXgW8puZCYyVIHmrMnLJJKUvbq7GA
 +byyDXkBJppJpMJjk71atANlVEliefQAOCU5NfsYkidfyc9IMsaoU8lyrdRbrJA24DjWVvQ4
 YOq+aUzBXf+s9JKGjNMg068gEsHUMTa4Fv0aXRnOJinFHeH/5UkJMp3yZOZdhMUcaENdgKOf
 M7RzanRw4/s10xF5uVJMFrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKv+Zvrgc91Zk
 b1wWZKMpQgBfaLTvNoQUz5hNCxRO5ZD2bb3KnODiJnGp6HGWyOEL/RGKmgTZNRd0MAnRGZE+
 LofNSwHaQ2Fi6Su2rWnR+Jwh8Mlas72IIcYvXImxjbcZRokacmbH+OWupkFjHFp2JAm8fX2P
 qL1bRJ1axvNeVtXM0o/A5Mihua4wHL4dlW0rXrK/fBquDmJlmSd1pDTMZmMR4GzY/x0sVaKl
 HueomfBWi0FYYn3JT2ttyjEavX0tSH0QoUJD5Wj6+VnxlaUwwQ7GBAQEFe2v/S9okq/QM5Eb
 VwZ/DI0qqo//1DtScPyNzW8oXiZrlsWX91bEMUk5wyXjKnZ+QCUAi4DVDEpQNgnstImAD8nz
 FmEm/v3CjF19r6YU3SQ8vGTtzzaESISN24ZIygfUREC/cLgsak0lBvEStslG6mw5vXuAi35y
 T2OqCk4hp0QgNQN2qH9+krI6xqltpLOQyY26x/RU2bj4gARWWK+T4mh6Fye5/AQKo+cFwCFp
 CJdxZjY6/0SB5aQkiDLWP8KALyi+/eCNnvbnEJrGJ4isT+q/hZPYLxt3d23H28xWu5sRNMjS
 Ba7Vd95jHOLAEaXUA==
IronPort-HdrOrdr: A9a23:QOYS365euNG77LK9dwPXwVqBI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc6Ax/ZJjvo6HkBEClewKlyXcT2/hrAV7CZniehILMFu1fBOTZowEIdxeOldK1kJ
 0QCZSWa+eAcmSS7/yKhzVQeuxIqLfnzEnrv5a5854Ed3AXV0gK1XYcNu/0KDwVeOEQbqBJaa
 Z0q/A37gaISDAyVICWF3MFV+/Mq5nik4/nWwcPA1oC5BOVhT2lxbbmG1zAty1uGA9n8PMHyy
 zoggb57qKsv7WSzQLd7Xba69BzlMH6wtVOKcSQgow+KynqiCyveIN9Mofy9AwdkaWK0hIHgd
 PMqxAvM4Ba7G7QRHi8pV/X1wzpwF8Vmgvf4G7dpUGmjd3yRTo8BcYEr5leaAHl500pu8w5+L
 5X3kqC3qAnQi/orWDY3ZzlRhtqnk27rT4JiugIlUFSVoMYdft4sZEfxkVIC50NdRiKpLzPKN
 MeTf002cwmMW9zNxvizypSKZ2XLzkO9y69MwY/Upf/6UkVoJh7p3FosfD30E1wsa7VcKM0lt
 gsAp4Y6o2mcfVmHZ6VJN1xNvdfWVa9Ny4lDgqpUCfaPZBCHU7xgLjKx5hwzN2WWfUzvekPcd
 L6IRlliVI=
X-IronPort-AV: E=Sophos;i="5.91,210,1647316800"; 
   d="scan'208";a="70253922"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2022 04:20:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byNAVGgn5Wu5/93wrheCYdKldVDGy+Xh0Xdn02BRVC/PD6k8XcQiZaAw29ley2J96VeqNxCmv35g/CERSsmtVdZ1dFPFmaXi31gbFsbH9YLJEm1uNQqdLs9ILli1iWDP3D3t6I+pbjSEL9Jt2TN7aOVEDIJwamyanXhUES8cGD5b9tz7uywgX+y46G6i0otnrfWa8CzqCxZx7cy/2vZoBt1KDglDiRTJtvmbE6ec85hkTtWFHx9smICVV3dIftlad8HNTRbMxaF+FG8UWHxdBkpzoqkRK0adzlkbQWIVbRKlrPZegHInkftwmd5A0J5LpBFGfmiaSiDdkmwvLJjgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tNblGtQgBJC4CHC5HvWW1EtnAyu/hj3bwrctcYARug=;
 b=lKpskpc/0kd6mgXbMM55GyI8vM64RtW8Bn9NWvxJCU3TmCN0IA/Q/HV0UwWY8Okv+f8nsuU2vAxxWIzrAs/bi5ceu1MuRzCw03KZhU8/4uXfPA9vK09joZeers0MiVtpYRKZRKNEc0Z9zDNneUNOtAHlPMv1pQNI0B2PGSQtCbFBzMYzPNMfDi8wGucx9WpYGhVMDgGcOaJULg0hyaJw3y2lea+tinq3ftUdCQsIkEG4owca/3BzK3RgzkxGwfrQNFs0tKzV2rLRIY7nElHN2D++E/6dQXhevSJ0KVozFAnMNr3pPbylqiu6z+aRORLKU3kNkUAW1L0z0vK8dDbILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tNblGtQgBJC4CHC5HvWW1EtnAyu/hj3bwrctcYARug=;
 b=o+ekJ8lBY+hoVhcqAslE3hn1HPdLaarksHHo5qXWP5ul6gUZd4Sek/Lh2nw9AVa8wPifX7icAJ6gdAVKJyxH4BGGVgTsRvoaZ394fJ8QCA5mu3x7YdfM1K/KfGIRJhSmaeOpzrCZ3lODs68CuluUMH1CiEJwhtHl5IELDweDvsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from DS7PR03MB5608.namprd03.prod.outlook.com (2603:10b6:5:2c9::18)
 by BYAPR03MB4488.namprd03.prod.outlook.com (2603:10b6:a03:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 08:20:33 +0000
Received: from DS7PR03MB5608.namprd03.prod.outlook.com
 ([fe80::5df3:95ce:4dfd:134e]) by DS7PR03MB5608.namprd03.prod.outlook.com
 ([fe80::5df3:95ce:4dfd:134e%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 08:20:33 +0000
Date:   Mon, 9 May 2022 10:20:26 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 03/21] xen/blkfront: switch blkfront to use
 INVALID_GRANT_REF
Message-ID: <YnjOyk04oAdoGaIt@Air-de-Roger>
References: <20220505081640.17425-1-jgross@suse.com>
 <20220505081640.17425-4-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220505081640.17425-4-jgross@suse.com>
X-ClientProxiedBy: PR1PR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::22) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5707a7a0-7768-416d-d176-08da3194c98d
X-MS-TrafficTypeDiagnostic: BYAPR03MB4488:EE_
X-Microsoft-Antispam-PRVS: <BYAPR03MB4488696FFC36EB34E71919E28FC69@BYAPR03MB4488.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxMU32zho4/N7Q5IEj+QphV0HyBMiGJqo1G4VDeFF9pQPRTaAcRZk5Lz2Kpgd0Z5vPlz1sLHA2j8S/yRV2Ugxx/ngsMcHQmxJrcYp8QaCTVLz8lyRtoqkNW88m6E1cIOTMz8bMl0duMavYJCinD5S9lkcY5usVomP2HuxTwSRYBKBV/78/Di4tIVB/ZgcSFKFQEyO58NlI7QU1lDexlec2xEwEtd0HrOhPXIrBv/reqWNbOE0aylptU+E9Eog1TVMZlheWp3ILrXRtJheEeSKm9qajhux8Kjgw6yU9ZTnzfu546OxVCjV9C9Pq5gZDVkNLyNvb6975Sm2Ud6azgwlxqPJHAmVbJCiAKwtRQDs+C3rzJ26LqefNaqB3+nSmZunQU/ZkCI9vlkqrHB88w5s5RDjHkkXTku60gswmsuVsha+BnKjJnU7YvpZ+uIx5fMgYpgmd3R/kvcNUDltCqfPwLJeQ5TAJaYZwEFmXW0jwNQfZ0edx2d7zM1DVuSy4zAk2Wms9oZzEfgZERCGS/4V6NTjoRusSkx08IK6/C4CuCnqeGNYZjxJCV4GoPeFZOVyzFLO9MJ767M5N90kyjWzpQj1LIIJEOSwFc+FTEc/hagmC4Wr8L5fGmZpH9eyGCXxtUbI1nR+AgILPZXEKsOBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(8936002)(85182001)(33716001)(508600001)(8676002)(4326008)(66476007)(2906002)(66556008)(66946007)(82960400001)(6666004)(6916009)(6512007)(9686003)(6506007)(26005)(558084003)(5660300002)(6486002)(316002)(38100700002)(54906003)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUxqbDNBOWo2aUtqeG1XcjNmRVdHcXVHZHUrSk9aTllKN28rdDlGZlRUaWhZ?=
 =?utf-8?B?VnVuaTRKcmtZbS9UQTFOdjBRWjZSMEs3blEvVGVsRlhRNUJ1ZHZyaVlmT3lp?=
 =?utf-8?B?dlBMUE5VRUdveWlBeHdQeGVtTTRqbDV1SEZxazB6SnJkdS9USkcwemppZG82?=
 =?utf-8?B?WGY4WWtialNPanlCZld3d0o0T1ZpZEJjVG1teWpQV1FNVllOMnkwTTQvTHph?=
 =?utf-8?B?WjFhV1FuSnczTDRKTjJIbmRESWdxK0NMMkthZ1RrS1Rya1RpM2RxSlVlRnFR?=
 =?utf-8?B?TkowMUNTT3NuYUdJL1h4eUI2QzQ3TDA3ME96dW9UVTVEcHAwNTczRmdwY01a?=
 =?utf-8?B?VDVMQVNyUGpvQnF0cDVmWUF2TVBibXFuM0VyV1Yrc2xYQjgxOXNWM3d2d3Jj?=
 =?utf-8?B?TGJjR29FT05UcWtyN0QxdXU2RUJkU05TdWlaYTFERnBtbHVsWE1BeElZRDc3?=
 =?utf-8?B?RSthZXFIMk9IeVFoS2l5M3N0T3M3ZitmL1J5RndXT0tqek5NWmlQbmxSOVVH?=
 =?utf-8?B?a1gxUkFZSHFWUEFlMnI0UGg0eVExdzhNY2VqOHU1b1VqcFg3ZjFXYWVSSjlp?=
 =?utf-8?B?YVFzRTNuUUZVYTF1M0g2Rm5SRkVlUUVoVzhsSFpJKzFLYUJROHNIdzM2TGVY?=
 =?utf-8?B?Z1ZLdU9xV1krRk1wNTljQkdJbW9tVWFHUkFqZzdIMXdNcEZ2aXdUT1F0L2Vm?=
 =?utf-8?B?cWQ3UnFjc3RyOERVd1kyZzhPTTlNMEtlYjE0eWhoL2txM0N3VjgraVRUMGhF?=
 =?utf-8?B?MFEwSmtIeGtiUEl2K2N0YTR2ZTc4ZzkzTmVkM1NnZVRkRDRKYTZBUkl6cTRT?=
 =?utf-8?B?UUtHVGdhMHphdk1haHdISWV5dWZuamN6MFlXS2QrZkRFVnhjWnIzN05Tck8x?=
 =?utf-8?B?c3JNRFVESWFIdXI3VUZtSWVid0VXbWttVEUrZUxrWmloa2lwc0ZGbm5pMkhz?=
 =?utf-8?B?dlVCVmxLUHd3QWZJVEdkZCt1VnBhRno0TGRyVVluclN5T2huZVc5NWJpT0tQ?=
 =?utf-8?B?T1lsZDNUTStLQUQ2VDlaNHJEL21vS3Y3aFNMelM3MUlBYm5hUUphUU5wMVFn?=
 =?utf-8?B?b1Q0WFRyWUpBQUlSaDZ5bDVNUFQyY3JaS2RJdks0Um9GRTdKUzRGRUxxY1FK?=
 =?utf-8?B?ZkE3RlFNTVBJVUhuTTFSRnVLL3VnRGtkaVlHZ281azdhMnQvaUxnSitKUkM1?=
 =?utf-8?B?WFpoYTZmSUpra1JYWkg2dlpQeHZrMEZQVXVTZ01EOUJHamZaeWlSaVJlNUhD?=
 =?utf-8?B?QzhCYXNHMm4zbndCWmZRQXEvTS9BckRGY2sraWxNdUVSMGw1V2N4VTlvaFlv?=
 =?utf-8?B?WW82NTRta0xtZzl4Wm9kTU03cVlhMHRwRm1SWG5jS3VqMktCNkdwZmVIYytP?=
 =?utf-8?B?TU5HVk9QTVBBRjMxbW9DWTJkV1p4ZzJobWdwUFZjSkMvYXlKSlNMb1hHM3A5?=
 =?utf-8?B?dlE4TzJDOVBhZTliTEZ3SlBMc0hqSmMvcksyeHJKMGdqK1oybExGOTMvV0li?=
 =?utf-8?B?d21Jd2FWejd6a3JzR3VTSW5HRVBIT0pXRzhVTkY5VlV5bm53eXpqUjQwOU4w?=
 =?utf-8?B?TUNTRXdvL0hGSStZQWw0Znh2b3JJSVdDRGhkblRMc3hhNklwSzUxUmt6NkRo?=
 =?utf-8?B?cU44VkNweXRicUpSMkk1YWJBVEQzMHdvUzVSRVBOWnl0b1lVN1dUS1p6ZDZm?=
 =?utf-8?B?L0RHakp0RnVrRTBFZWxhTGRHdTRTZnFFMmVnakVLd09nNEFGT3dvcU5NVEEw?=
 =?utf-8?B?M3JqM2xZSThQbGdmeUo0THU5OEJ3MGNjb09lNW5IVm1PcENPSk1uSU51bU92?=
 =?utf-8?B?WkgwUEJqYzJmZ2orSVVBeEZkNDJtUnA3WGs3dlZWeVIyaXpqSGdOZHc5WDJ2?=
 =?utf-8?B?Znh2SDBmZWY4ZEVrM1lTZ252azRzL0I4cll6ajZQQ2laWkpXcFJ3K0xVNWFw?=
 =?utf-8?B?aDVRb0JQWHhpbHRsR2NWaVI1cHk3Wlk5UCtEUnpSTkEvWjJqd3pqSkhtUmFH?=
 =?utf-8?B?S0hwV20ybDJIMzhjNFZVN2tRczlIVDE4bzNlV2FlOC9XSDFOVGlSdkpZZ2Fr?=
 =?utf-8?B?bDVob0ZhdzRYbGMvZ1FKTGNJMVlaQ3RRRlVjbGhiS1Y3UXdjYnVRMTZGQ0VV?=
 =?utf-8?B?VndzM2E5dllvTjhOZ0FUWExDSEtUa0tnZ2JVVUp1NnZqSGNMNkluVzA5WUpM?=
 =?utf-8?B?M2tZbEFZVkFkN3ZDZjJ1WllyZUV6b3N6WW9zRHFuVVN2Tk9QZXJrOVlvWHJY?=
 =?utf-8?B?WnRKdkZyZHl6YnhuckhYeVpyVThMUTJFakVEdzdVbXB0TmRuTHpyVEFRYXFC?=
 =?utf-8?B?Y01vY3NBL3FBVnpUdmViQ1VqU2hTd2xpWjFoWW0raXVwd2E2NUxwdz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5707a7a0-7768-416d-d176-08da3194c98d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 08:20:33.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMDVE+vsWBnSKwc6MQKKBVFpNN9OM67dcrF1ZymzLl/abGWMkQung0lu2rzckiTYISDeqRp+4kkfskWQcq1Cgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4488
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 10:16:22AM +0200, Juergen Gross wrote:
> Instead of using a private macro for an invalid grant reference use
> the common one.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
