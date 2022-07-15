Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1D57662F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiGORih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGORie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:38:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E4752FF8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:38:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGGkXM016517;
        Fri, 15 Jul 2022 17:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8M4g5kC9YQcU6ye/QLXmoh3Gg8rAK671DixuDRk1K+A=;
 b=qsFtGuwnsMk1YQmu/ZXfBqYLCa/PvO1Qna/GVOit86dtIzXGZbxtT16+AdQ9gV58xDzx
 bpMzYdcCGz74TeiROqSaT9oVbOElnQ5T9cveQ2MMqoRTtrXp9/jIhKaEIkhMZyJmcKc1
 uNZvEodhaWiKN34NwVos//Jv1TAzf7doRLG7QE0F8+8ScQrm1thpLhYACWe8yt+aSZ9O
 bjujMKH8m6dnj8cUVsur+02M1JgWuU2l0A3MfQPVvWZy2ZzCCqGSsdwUK+qdV98x3Jmd
 CpJV6/c5hVq0/WJAKTLowrIXYc2l2G2VKK+UIT8T4U1iuCp8vEpZFaoCXoSP+/ZEcmS5 pQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgytrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 17:38:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FHaMTi040308;
        Fri, 15 Jul 2022 17:38:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7047uu0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 17:38:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlWOmQSL05UE+/q+I+iFfo9BYanyWjA9fWtkHkBvJeo5qeIwGm6mQ4t4BumLdKOplTzcJbsj8c6Dzth4M9ER2Wx1TWa4EBP0O38DZmzFuAQj1/w6ytG5LOduJgdjHXS07O++hkYMA+xixd1GAsb3Ttoe0q3b1SkokRHi/b3qUzkmByvtAYI8yTBEMuiEjcctNcaDjl+OYptmO0+mBrQ1jsNJkt1iEovAvA+6d3Q5Ywuk9klbMGxz6M+4FeuO1ezejfB+YVoy6+m8bjd1Malii114eERATM1XA393/FqftK6qtse9MZBJairhtJn6DniCt6aG7Wb2aLVda0TNYHHIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8M4g5kC9YQcU6ye/QLXmoh3Gg8rAK671DixuDRk1K+A=;
 b=hIoJ1uM3DKlv0UkuvUOrtUUV8dAxEbkMxAlRv0XxqhqubyRVFJ9hFulCbIK7RfNhEH0B9VJKHvfTXjsAzi0jz+K0sLWZzFDr6N+bEHJ4JsqhLAhM6Zyz/rJkE9E+HgXN0Lo1g2amYsFA53bNhkI3/34s0Z6mnbALp9QHdamhRYKzILjbZuFiLdMWzrMUT+ubR0rFodT5agcqITx4MlzrwKJXYJ/9WlN4N0xWFCZ49tWlBCunjXOGQbS7Wi8eQV5xaAS7vlOm4BwM9eX2yKbRCGrcHNhFHFiYxGTgXvJLWmJeZibUZKP0r/JJ9arvALUj6UFsKjsy2xAWxo0ZVon32g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M4g5kC9YQcU6ye/QLXmoh3Gg8rAK671DixuDRk1K+A=;
 b=oo3DVQqUzeKYVVhKTZXgb+jTzFDyHkvmF+W7NwmyqcEj+y1Q7f+xIDUBWoMCR6Z/b4GY4vD3CiZvs6TuB8xVQvWIExCIuTnzDecjSvAt568HKV22urSnjUniljtR93oI/ITjsFF+zqIDWKNmWErhkPR9wakIDRA7hVhnbS29MPQ=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH2PR10MB3974.namprd10.prod.outlook.com (2603:10b6:610:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Fri, 15 Jul
 2022 17:38:26 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e%5]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 17:38:26 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi/nfit: badrange report spill over to clean range
Thread-Topic: [PATCH] acpi/nfit: badrange report spill over to clean range
Thread-Index: AQHYlX3HVbDs2AmFoUigIZUcRQZQvK17eX+AgAGCqQCAAAjvAIABgQiAgAAa3oCAARdnAA==
Date:   Fri, 15 Jul 2022 17:38:26 +0000
Message-ID: <2894719d-3074-2934-a19b-2d26f4d03448@oracle.com>
References: <20220711232658.536064-1-jane.chu@oracle.com>
 <62ce16518e7d3_6070c29447@dwillia2-xfh.jf.intel.com.notmuch>
 <09df842d-d8e4-0594-56b0-b4bb9ea37b67@oracle.com>
 <62cf622a32e1_16b52e294ea@dwillia2-xfh.jf.intel.com.notmuch>
 <8b13446a-65ac-0cbd-6c17-0f9e1cfbb048@oracle.com>
 <62d0bbb19ed1f_1643dc294cc@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62d0bbb19ed1f_1643dc294cc@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2524932-5cf2-4208-86c2-08da6688d2d8
x-ms-traffictypediagnostic: CH2PR10MB3974:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0vfEEjCw5pt5YcCP2+9GCPoZ2ZyG/huVW/qh1CD04Ev8pzJnjS4FbXfIWTPSqUVGd457W//ogdcPQ6TxY80PmUVDevtZy/8bZmIpzrze/aeTahTfFnzPGoJNLqbZTjwveT/QfYAme/QKxtKXRNiNalut1uNZiY3z1ClIPfwEriMLB2K2sj3Bk60yD4p2FvmJigeakN3j5kxCcBJaf1u/mXMCMA1+hx8Eu7zSrtVy0xvh80wTPZukwY+fCmCIgzUw6Acd6K2Pymf8sPsebc5UjKh5iKi60DgyVRsElMy+Tj3xhaYaR0vSyiOfxPH9GzGYn5+9C+Yo8z1IB7DHRDhv8ofq3sKYUxzUOAq9uqY2/FUedZL2DYYftS5B+JqVpKbfG+w2L7Mj4NK9fLBnTLnEVxrALvaq9+o8NXGkdFuQVrkkoAOWF34CjibL+dtcB7TZn4Qch13ffvm7LN41emSd5IYBU63cg7XYhhXdhj6hi4llBW5r5stjL3xLkN3hu6khQQsR7y2hnthQYaRyRm+Nlwl3ddgJK+27ckvoomgpmi96ZLPehbDNA1IlSkA4vBoFQ2Ypv3woYe7m3OAHOo4h842Zed8bmYY0l5LdD30ZHBjd2+R7kR9JQV1l/lpxkVTT0Rz7HFhYNu/BidlhI9VUnFXC9JZIZXKQLChUyOVgtGC1sJPEDpURKYR6ebU90x5aAEZKWZxjtCG8XJz+Srf77ASzF3YyoPXZ6ca3Fh60TzZqmLZDBxKzj6oDZ9hhwCAMGtH13phJQmIrTLG3qmWG9pAjqMq7E4GI5Dmk2c9EfP+XvHG5upODKkWKMnTa/LR57IU/Cw8AsTQBBoQXJJOPd6nyWsgsf+KQmJKd/kMDxAWvzI6wsxJOEN5UnUMq3NFg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(346002)(396003)(366004)(44832011)(122000001)(38100700002)(66946007)(26005)(6512007)(31686004)(5660300002)(6506007)(2906002)(110136005)(86362001)(41300700001)(36756003)(38070700005)(478600001)(66476007)(66446008)(66556008)(316002)(53546011)(83380400001)(6486002)(64756008)(2616005)(71200400001)(31696002)(76116006)(8676002)(186003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFgxSndjWTBBdnZ3UlVlL2t6SzlBSVZTL0ZJU0c1S0VYbi9GclVMV24xVld2?=
 =?utf-8?B?djViMGlVYUp2MmRJblNDcVFIakJuRjFNV3dUUHdmdStGWUFOVWVtOXk4dnNP?=
 =?utf-8?B?djV3Q3ZUZnJJRWVHb01GdlpwdVd0UEpXYnpXUXhqc3dNeWZINkNTdHNjb0Ex?=
 =?utf-8?B?anEzNmRBcC84TzZ1SWhDMk1lcmFscVBYU2hNVnBMN0hyc3lxbHUwTFdCanBi?=
 =?utf-8?B?WjNSaFY2amRLL25CMG5FeUFHRGdXSHIyWWE3b1lEVkNhbHI4YzRYUDk1Y1VN?=
 =?utf-8?B?U3FzK0IxcTk4NGswOFZJUHBWNTk5S0RTNDh1eTdkNHFOWGNBMzFqa01rak5x?=
 =?utf-8?B?cEhLbExjcVMzbjBVMXdmdGpYdlhJNXhhamZSLzFWWWQ5Z3dTQTZwN3Z3a296?=
 =?utf-8?B?VzdvTk5GTHFndEc1OFQyWkIwVXNWQzRZM3o5eTNjelB3dlp6dUpjL3ZaVDA1?=
 =?utf-8?B?M1E4Q1ZnSmpDREk5T255Q0c0V1dMZW4yNzNwYzRXV3ZLNjBoenAzdmF1Uk0v?=
 =?utf-8?B?aXdSdGFwb0RUSkZ2d296bDhYQkxhcDd6ZFVmYTg1YjQwMzFrUERHc2hGTzdr?=
 =?utf-8?B?ZWkzc3RUNkdQZU9LZkdZenVqcXhlclN0b0JuRm9aa2tCVWFTcDhBbWd2OUI0?=
 =?utf-8?B?NkovL0pWR1Evd2cvcy84YXM0R1dmS1Baclh2K3VMc1JIclc2N1MvZTBKOEJl?=
 =?utf-8?B?MFVIemhJeTF5MXhjVGdQc002UWFWMzBzSkdqa0ZWREIzL0N0dnVjdzRlQnRq?=
 =?utf-8?B?WUcrUERSZmZzdWtHTzRSc1BrQXkzWGJlS0ZTZHBhOEZKTStpYngrMDU3S01R?=
 =?utf-8?B?N1B5cmVTdnNmZkpuNjJDc3V6TlJpaFAwVjFzd2x2NnhhS28xVDJMQjhZMDdH?=
 =?utf-8?B?U3Q1VEZ4SHhtK3NMbXVZSWNKc1RIaThXYXZuT2JRTk10SHNwNG03dWpiQ0RX?=
 =?utf-8?B?cnBSajdtMTJjSGtBTStkZHpxYTVqMDFyeElseTVzbkVsN2ZwYmJvczI5cVYx?=
 =?utf-8?B?akZnTG1sa2thclVPSEZyaVkwc0tRSVF0dVdEemQyRWw4NUlJNENFc0lrMEdQ?=
 =?utf-8?B?ZFdvNW5jRzJiWXJwbHVQZTFWL1MyOUc5bUd2cU5wcXprSS8xcWJxNVEyUDhM?=
 =?utf-8?B?dnBvZzFHUFM5emNnTXZ1TnVTZTBsZnB6Tm1JclVWS1gyL0VDYU0zakwrempj?=
 =?utf-8?B?clAvU1VDNGVSanhXTHpOM3h2aFpFbHhWWFN4d3Z6UjFlcjhWYjFkNmI3Rm1F?=
 =?utf-8?B?SjAwTThiVmRoaTJwNGt3SnlFV1k2YTRnUEx2NVZHTm9LN3NkcWpVd2tGWHVF?=
 =?utf-8?B?Vk53L0thRnJPOVJtYXRQNERua0pvR0JEUy8ramFlSk9JOFE4aHhpSHVZaFhr?=
 =?utf-8?B?aG1oUWZETHpSMnBreVZ1OTEwKzVGakNmS0RHTUlBNGhGT29UQ0E5bkJ5cGty?=
 =?utf-8?B?RDExaFAyeGh4R2VJVzZSUVZwMi9sVTJPR2o2TldqVXd2N2pab3JJL0hsVHBn?=
 =?utf-8?B?ZzVQUEdOc3BxWXp0WGFnZDh0cGFSd3h2WDRHSVdmNG9Lc3dqM1I0SDRpK2J3?=
 =?utf-8?B?Wm9ESlhHbkFMKzZ2NnJ3RjNROFdpd2E3MllXV3VUVUVMNW1PR1kzd0Zub05G?=
 =?utf-8?B?L09hT2htNjYrS2FUanYzOEVjTVlkY1R0THNMSkJhUGhhTnh4NzluYUhWdWRO?=
 =?utf-8?B?V1VQSnc0djZKTlFlZjdVcUVieHA1M0ZvSVFiaTNqSzNMWC9KMnFtN1FFWWxz?=
 =?utf-8?B?MTRYZFpUZ2xNWXJ2NTRuT1VwV1RqNnVBQ0d4SnZmcnNGSHcyMlhDM0xiRXJQ?=
 =?utf-8?B?OTg3WVpOemFNcEd3MVZqSGtVUm5Kc1ZoV2hYUC9oSHlLcndOUFlJZ0FGZmJo?=
 =?utf-8?B?dzlMd1dmRE9Gb0NvOXpZMUQrYkdFMWgxUVRoTjdsZnRZcUhTdjdEMjdxNEZD?=
 =?utf-8?B?MlQ1amViaXFLOXJTQzFNZXFHY0lkRnlDa21wSk93SHRFQWVMU3RJK1FHSVdq?=
 =?utf-8?B?c3pWaXZKdjU0NzBnTThlYXlrYmlDWkdZaTA2TWgxR3ZGc0tPUDNwMEhHWmFU?=
 =?utf-8?B?d0VpUFhsTnp4ZDQ2U3ZGdlFKRFY1Z1hsY3JkRTJsSnQ2YmtXb3FUcVovdWVp?=
 =?utf-8?Q?lcc8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9887B8CA2778C246B849403DF665C24C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2524932-5cf2-4208-86c2-08da6688d2d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 17:38:26.4868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2mz6vz/3Onxrwf0mNwD1niO+cCVPqJ0qOKXz1vNfr7uL7yfJ8AQDlIXStaZ2Rpk+weioxeYp8/mtmSTjc+VgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3974
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_09:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150078
X-Proofpoint-GUID: XTcmKwejSYhCdPvOXAi6fWwqwIsx6-be
X-Proofpoint-ORIG-GUID: XTcmKwejSYhCdPvOXAi6fWwqwIsx6-be
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xNC8yMDIyIDU6NTggUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNClsuLl0NCj4+Pg0KPj4+
Pj4gSG93ZXZlciwgdGhlIEFSUyBlbmdpbmUgbGlrZWx5IGNhbiByZXR1cm4gdGhlIHByZWNpc2Ug
ZXJyb3IgcmFuZ2VzIHNvIEkNCj4+Pj4+IHRoaW5rIHRoZSBmaXggaXMgdG8ganVzdCB1c2UgdGhl
IGFkZHJlc3MgcmFuZ2UgaW5kaWNhdGVkIGJ5IDFVTCA8PA0KPj4+Pj4gTUNJX01JU0NfQUREUl9M
U0IobWNlLT5taXNjKSB0byBmaWx0ZXIgdGhlIHJlc3VsdHMgZnJvbSBhIHNob3J0IEFSUw0KPj4+
Pj4gc2NydWIgcmVxdWVzdCB0byBhc2sgdGhlIGRldmljZSBmb3IgdGhlIHByZWNpc2UgZXJyb3Ig
bGlzdC4NCj4+Pj4NCj4+Pj4gWW91IG1lYW4gZm9yIG5maXRfaGFuZGxlX21jZSgpIGNhbGxiYWNr
IHRvIGlzc3VlIGEgc2hvcnQgQVJTIHBlciBlYWNoDQo+Pj4+IHBvaXNvbiByZXBvcnQgb3ZlciBh
IDRLIHJhbmdlDQo+Pj4NCj4+PiBPdmVyIGEgTDFfQ0FDSEVfQllURVMgcmFuZ2UuLi4NCj4+Pg0K
Wy4uXQ0KPj4+DQo+Pj4gRm9yIHRoZSBiYWRyYW5nZSB0cmFja2luZywgbm8uIFNvIHRoaXMgd291
bGQganVzdCBiZSBhIGNoZWNrIHRvIHNheQ0KPj4+ICJZZXMsIENQVSBJIHNlZSB5b3UgdGhpbmsg
dGhlIHdob2xlIDRLIGlzIGdvbmUsIGJ1dCBsZXRzIGRvdWJsZSBjaGVjaw0KPj4+IHdpdGggbW9y
ZSBwcmVjaXNlIGluZm9ybWF0aW9uIGZvciB3aGF0IGdldHMgcGxhY2VkIGluIHRoZSBiYWRyYW5n
ZQ0KPj4+IHRyYWNraW5nIi4NCj4+DQo+PiBPa2F5LCBwcm9jZXNzLXdpc2UsIHRoaXMgaXMgd2hh
dCBJIGFtIHNlZWluZyAtDQo+Pg0KPj4gLSBmb3IgZWFjaCBwb2lzb24sIG5maXRfaGFuZGxlX21j
ZSgpIGlzc3VlcyBhIHNob3J0IEFSUyBnaXZlbiAoYWRkciwNCj4+IDY0Ynl0ZXMpDQo+IA0KPiBX
aHkgd291bGQgdGhlIHNob3J0LUFSUyBiZSBwZXJmb3JtZWQgb3ZlciBhIDY0LWJ5dGUgc3BhbiB3
aGVuIHRoZSBNQ0UNCj4gcmVwb3J0ZWQgYSA0SyBhbGlnbmVkIGV2ZW50Pw0KDQpDdXogeW91IHNh
aWQgc28sIHNlZSBhYm92ZS4gOikgIFllcywgNEsgcmFuZ2UgYXMgcmVwb3J0ZWQgYnkgdGhlIE1D
RSANCm1ha2VzIHNlbnNlLg0KDQo+IA0KPj4gLSBhbmQgc2hvcnQgQVJTIHJldHVybnMgdG8gc2F5
IHRoYXQncyBhY3R1YWxseSAoYWRkciwgMjU2Ynl0ZXMpLA0KPj4gLSBhbmQgdGhlbiBudmRpbW1f
YnVzX2FkZF9iYWRyYW5nZSgpIGxvZ3MgdGhlIHBvaXNvbiBpbiAoYWRkciwgNTEyYnl0ZXMpDQo+
PiBhbnl3YXkuDQo+IA0KPiBSaWdodCwgSSBhbSByZWFjdGluZyB0byB0aGUgZmFjdCB0aGF0IHRo
ZSBwYXRjaCBpcyBwaWNraW5nIDUxMiBhcyBhbg0KPiBhcmJ0aXRyYXJ5IGJsYXN0IHJhZGl1cy4g
SXQncyBvayB0byBleHBhbmQgdGhlIGJsYXN0IHJhZGl1cyBmcm9tDQo+IGhhcmR3YXJlIHdoZW4s
IGZvciBleGFtcGxlLCByZWNvcmRpbmcgYSA2NC1ieXRlIE1DRSBpbiBiYWRyYW5nZSB3aGljaA0K
PiBvbmx5IHVuZGVyc3RhbmRzIDUxMiBieXRlIHJlY29yZHMsIGJ1dCBpdCdzIG5vdCBvayB0byB0
YWtlIGEgNEsgTUNFIGFuZA0KPiB0cmltIGl0IHRvIDUxMiBieXRlcyB3aXRob3V0IGFza2luZyBo
YXJkd2FyZSBmb3IgYSBtb3JlIHByZWNpc2UgcmVwb3J0Lg0KDQpBZ3JlZWQuDQoNCj4gDQo+IFJl
Y2FsbCB0aGF0IHRoZSBORklUIGRyaXZlciBzdXBwb3J0cyBwbGF0Zm9ybXMgdGhhdCBtYXkgbm90
IG9mZmVyIEFSUy4NCj4gSW4gdGhhdCBjYXNlIHRoZSA0SyBNQ0UgZnJvbSB0aGUgQ1BVIGlzIGFs
bCB0aGF0IHRoZSBkcml2ZXIgZ2V0cyBhbmQNCj4gdGhlcmUgaXMgbm8gZGF0YSBzb3VyY2UgZm9y
IGEgbW9yZSBwcmVjaXNlIGFuc3dlci4NCj4gDQo+IFNvIHRoZSBhc2sgaXMgdG8gYXZvaWQgdHJp
bW1pbmcgdGhlIGJsYXN0IHJhZGl1cyBvZiBNQ0UgcmVwb3J0cyB1bmxlc3MNCj4gYW5kIHVudGls
IGEgc2hvcnQtQVJTIHNheXMgb3RoZXJ3aXNlLg0KPiANCg0KV2hhdCBoYXBwZW5zIHRvIHNob3J0
IEFSUyBvbiBhIHBsYXRmb3JtIHRoYXQgZG9lc24ndCBzdXBwb3J0IEFSUz8NCi1FT1BOT1RTVVBQ
T1JURUQgPw0KDQo+PiBUaGUgcHJlY2lzZSBiYWRyYW5nZSBmcm9tIHNob3J0IEFSUyBpcyBsb3N0
IGluIHRoZSBwcm9jZXNzLCBnaXZlbiB0aGUNCj4+IHRpbWUgc3BlbnQgdmlzaXRpbmcgdGhlIEJJ
T1MsIHdoYXQncyB0aGUgZ2Fpbj8NCj4gDQo+IEdlbmVyaWMgc3VwcG9ydCBmb3Igbm90IHVuZGVy
LXJlY29yZGluZyBwb2lzb24gb24gcGxhdGZvcm1zIHRoYXQgZG8gbm90DQo+IHN1cHBvcnQgQVJT
Lg0KPiANCj4+IENvdWxkIHdlIGRlZmVyIHRoZSBwcmVjaXNlIGJhZHJhbmdlIHVudGlsIHRoZXJl
IGlzIGNvbnN1bWVyIG9mIHRoZQ0KPj4gaW5mb3JtYXRpb24/DQo+IA0KPiBJZGVhbGx5IHRoZSBj
b25zdW1lciBpcyBpbW1lZGlhdGUgYW5kIHRoaXMgcHJlY2lzZSBpbmZvcm1hdGlvbiBjYW4gbWFr
ZQ0KPiBpdCB0byB0aGUgZmlsZXN5c3RlbSB3aGljaCBtaWdodCBiZSBhYmxlIHRvIG1ha2UgYSBi
ZXR0ZXIgZGVjaXNpb24gYWJvdXQNCj4gd2hhdCBkYXRhIGdvdCBjbG9iYmVyZWQuDQo+IA0KPiBT
ZWUgZGF4X25vdGlmeV9mYWlsdXJlKCkgaW5mcmFzdHJ1Y3R1cmUgY3VycmVudGx5IGluIGxpbnV4
LW5leHQgdGhhdCBjYW4NCj4gY29udmV5IHBvaXNvbiBldmVudHMgdG8gZmlsZXN5c3RlbXMuIFRo
YXQgbWlnaHQgYmUgYSBwYXRoIHRvIHN0YXJ0DQo+IHRyYWNraW5nIGFuZCByZXBvcnRpbmcgcHJl
Y2lzZSBmYWlsdXJlIGluZm9ybWF0aW9uIHRvIGFkZHJlc3MgdGhlDQo+IGNvbnN0cmFpbnRzIG9m
IHRoZSBiYWRyYW5nZSBpbXBsZW1lbnRhdGlvbi4NCg0KWWVzLCBJJ20gYXdhcmUgb2YgZGF4X25v
dGlmeV9mYWlsdXJlKCksIGJ1dCB3b3VsZCBhcHByZWNpYXRlIGlmIHlvdSANCmRvbid0IG1pbmQg
dG8gZWxhYm9yYXRlIG9uIGhvdyB0aGUgY29kZSBwYXRoIGNvdWxkIGJlIGxldmVyYWdlZCBmb3Ig
DQpwcmVjaXNlIGJhZHJhbmdlIGltcGxlbWVudGF0aW9uLg0KTXkgdW5kZXJzdGFuZGluZyBpcyB0
aGF0IGRheF9ub3RpZnlfZmFpbHVyZSgpIGlzIGluIHRoZSBwYXRoIG9mIA0Kc3luY2hyb25vdXMg
ZmF1bHQgYWNjb21wYW5pZWQgYnkgU0lHQlVTIHdpdGggQlVTX01DRUVSUl9BUi4NCkJ1dCBiYWRy
YW5nZSBjb3VsZCBiZSByZWNvcmRlZCB3aXRob3V0IHBvaXNvbiBiZWluZyBjb25zdW1lZCwgZXZl
biANCndpdGhvdXQgREFYIGZpbGVzeXN0ZW0gaW4gdGhlIHBpY3R1cmUuDQoNCnRoYW5rcywNCi1q
YW5lDQoNCg==
