Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F04502EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbiDOSzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiDOSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:55:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AC8AD133
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:53:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23FIlFUE008564;
        Fri, 15 Apr 2022 18:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=O4TwGWxYXspvun7P81MIsgIKp6As4GUnRGVC6m84nCc=;
 b=iw4Dm8RQIQo627/JNWdablpqLLbkBAT2SVrCZhJmN4LDoT1sVQrz9JTh4QYW4kAv2Awn
 AjbSFb/vdEDDy7Ark2tBLAP4Y2sUl7RdN9aFLErKmOH/EYG620M/F9Rn893rBAabBnTe
 L3HhhyNzHrIPpK/b+W8C5ZwZ3CvOQOJwLa5WrUkz7LhbD9F2DkG6vA54m9fr0FxZXn94
 aq0c1rte2UVSQ1K494bcHOy/Bdfnl6SAyt/AHbu5Sp9UTfuySQl2i11TBfZOLcn2CXbR
 g0JpL6bBIqGyaOvCkegr0pqeMU1+lxJAuAaT7oxFYfuPsx8EwoWCKWaCyu5KZXTw4Gam 3w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2qup6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 18:53:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23FIps43028169;
        Fri, 15 Apr 2022 18:53:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k6dtas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 18:53:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxEUCLES7RmGWNFvOg5vDJs2akeauriZTup4QtjE015LLhTfKpNlq5L+3R/ZY0CI0yZCh+Kmcq3eNGupb10UYwMk3zyXQT9sqtoaSw1gRVO/2JRIHNJp6azd5zTcUaDFBS7ji+jaCOMhIh+UzJAbFVPwgDzRuLijcB1W8tbfW8eBXyIcqYFMtrtznWSMenUxN3lhnQQR8xBf7KO0lcdUKiskJi6Qw6P1jm1YLDepiKXgzRrm3JAl+WjiWSgcO/LwGYsReCvWlIltxTb8s2oXfkMdPSxqNenWV9I2vBjsEC0IGq/yRXZP+Zx7kVQ6zSjnWLAkZKM7K5AYa+t5h/36nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4TwGWxYXspvun7P81MIsgIKp6As4GUnRGVC6m84nCc=;
 b=ZE2hS9yISs7OrI46BX7Ne4QH/h6K9UhIi42HlmAHeQavYl+x8epETWq+V1Z2SQJl2jqKIoDEnAdbPwwJxXC7Ilv2R58vLI3u+0KjMU6vuZ3MzZ+roo72AG1R+roYmHZYroDx6x1Oz+nLwdz7gqkGydekj+v+75B+eiJJmQrIVZ2x2qgzqGwXeUv4GzajLC4aBl+ui6pUDg+WPBR9dAdfYOEv8Yv6EDv5hC3oDeD8ST0Y+0AnTKNdf5Qc2R15M7E2bpHxWdyiupsFFdCTbwkGn9jlXtvtjybNfhGx/MU3tzirb3O8dH8IgzYfpV+uO8mFZ2D8ZnAXreWCP/QqrqOQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4TwGWxYXspvun7P81MIsgIKp6As4GUnRGVC6m84nCc=;
 b=OXlqJmip3hsmoUpkK7MVlXbwmhxvOY0LYrgeEbdV5iVaTfBzFAMENhl+UsyXcG/1xPJohEgDY8es1B1Q3mBKeiYf3owO+cO1LId9RRhK8ZRXo+U0em/Ld97sJTaKJp/bijfj4J1AV8MSGqRCvPVtryLgaww3WnJHAIvZvEzyYn0=
Received: from CH2PR10MB4344.namprd10.prod.outlook.com (2603:10b6:610:af::19)
 by MN2PR10MB3789.namprd10.prod.outlook.com (2603:10b6:208:181::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 18:53:03 +0000
Received: from CH2PR10MB4344.namprd10.prod.outlook.com
 ([fe80::2143:b691:57c5:7643]) by CH2PR10MB4344.namprd10.prod.outlook.com
 ([fe80::2143:b691:57c5:7643%7]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 18:53:03 +0000
From:   Qing Zhao <qing.zhao@oracle.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Kees Cook <keescook@chromium.org>,
        Bill Wendling <morbo@google.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: toolchain mitigations plumbers session
Thread-Topic: toolchain mitigations plumbers session
Thread-Index: AQHYUEbqQRHvn8TmMUa7Bz+ctF1QuKzxD6SAgAApQACAABqggA==
Date:   Fri, 15 Apr 2022 18:53:03 +0000
Message-ID: <C5BA9A50-1BB8-446E-98C8-E5F7680DFFA1@oracle.com>
References: <CAKwvOdniB-+F37ygZhRytBGVFjwnukyOpmoiJTCeusMdb=6_=g@mail.gmail.com>
 <3DE35A81-1FC6-4EC7-8F3A-B395B576644D@oracle.com>
 <CAKwvOd=CqOfd=zprWQPYoddgnGPJMb_sdk2Eut9DZNJq_fFJ-w@mail.gmail.com>
In-Reply-To: <CAKwvOd=CqOfd=zprWQPYoddgnGPJMb_sdk2Eut9DZNJq_fFJ-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7250d739-c97b-476b-0560-08da1f112bde
x-ms-traffictypediagnostic: MN2PR10MB3789:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3789B0C217FBB5872C1B9CBE80EE9@MN2PR10MB3789.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K8H3Msrd2ggecs1zAQnuOWsbqM2O4MV1HJEp3IcYSuBhjbo761j0cd6i2d3B/bZxjRvmpXRYf4mHq8Vo0InxSjitepRKojcxmCWxhUykYXLgTOL47AwLsaE74Ua6APQcShcV93y8iMRt1rGjKCIg5a03x6l54EbPcOh/n9JkSz4zGLHXLVvswb3Tz2skaNUAGwqHGlZWQoHVpWxErgDXooVoU6nqi5d6PkmL6fHVOAlmtP4bcIve9w5pCsXqrYAWQO9rMzaBsuZz7g2MbxkCC80l8yB8Nfb7tu1R5h5O7Re6jj0quULa+VrWhd+qE+LjUVOqRZkrhUqoFjbascZ6wHzakCuJ0HJE82u3b02eHA4UbEygKATE5lBNhuGMAnjT+dh5W8naZICitAuOeK4IyjnEUtNEn2K9JvThEVr/uSAGJuaozu0KoLm1PluiqqaBltp9EV2oC0M22+GRXaTPNEeMJReSG5aKeJKvsN3h0+PW5I47qB3UjodfNwdSVoQ+eb0T2U8fLjx8EHewbuXrBC2g2FlRPxQ+7ntnWNX+ajXi1Tzf101WYuQ5Sm5MOR6a88J3BCmz6Qb/Rx/UuY8GjfKizh9eRQMsV6KmSHWzAsxbgJrL7F/0Azf2UHqC7tquDcWxGbXKVIKtS/9ZgSaRK1My5KYVzN70ko2MgZ8JVMtQ0v9bQKO3Gd84WrKAVR3w6fx33OSFDkj1ci+Z5N3FAgZTxxF40cWjsUlMEL4TIoGrA2ausQAg30b4SdsIq9We
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4344.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66446008)(2616005)(66556008)(54906003)(6916009)(44832011)(53546011)(122000001)(38070700005)(4326008)(71200400001)(91956017)(2906002)(33656002)(5660300002)(3480700007)(186003)(66946007)(8936002)(6512007)(6506007)(76116006)(8676002)(64756008)(316002)(508600001)(36756003)(86362001)(38100700002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEFLalozby9LSTlTc2FEbDVPdmhJam9OTFplWEhJT3B1L3VWM3psUndYdXBO?=
 =?utf-8?B?dDRGT2VqRTZkQkJjRkNsRm9ybThoMWswTm9jVmlXNXIvRkowR3JWbVJQbmZy?=
 =?utf-8?B?QlRLY1NrVlpqcjN6RGIrY0QwdGIvNk1zc2RWRzJNM2haV3luQUlack8wR0ZQ?=
 =?utf-8?B?UlVsR0k5ZzlnVEQrd2M0bXRvUFRacy9QQXZJTmlXT0pFZE54NFMvTytsR3Nt?=
 =?utf-8?B?NFZLRHlxdEdveDMrdEYrczFsM0RoQXEycXlEUzBpUXc1VnVHeHRuV3VCRXFq?=
 =?utf-8?B?ZkY0SExvVjBOMzZHZVMvOVY4dVZUVks2Uzd0R3BMTTE5TjZnbEVaOGt0dGFN?=
 =?utf-8?B?NG4vMEEycTgzb1VrWE9Fa3Y1T2QzYVA1bHpVcE1hSDJmUkxxT0VuZHVrOUxL?=
 =?utf-8?B?aUxMSGNzb052YmhTbTVRckVsLzZVVElZK1FFVTFpZ2Z3a0orWnpjNy82Y21D?=
 =?utf-8?B?Ti9vSUJMN1RtVUtlSVJHQnorcDhkYjhMRnRUMU54cUhrbmlrT3pZMUpxaVA2?=
 =?utf-8?B?TDRXUityNHphTmN3UDdhd3liUkwvZDdhRS84bHVQNkVobEcwUGdQU2tZa3N4?=
 =?utf-8?B?b05LVkdtMk4wV28rM1FDK250ZUJXT3hJb0d4MS9qMGVadzROb21pM0kyVU1k?=
 =?utf-8?B?TENILzVoMmk3TjBIZ2VrZVovWi8rSGl2TlM3VXQxU2diQ3ZsVkJuZGZJZ2tk?=
 =?utf-8?B?dC8weEJqOVRBeUwyREJ5VkJqdDllTWl4bFNMY2xIT3VSdDBEWXdHekxYNlNx?=
 =?utf-8?B?cjBDb1pTOGIzZjNaS3A1bEhtK0ZqaTdIRlN4S3hLc0JDUElDOXhhOWFrL0xC?=
 =?utf-8?B?VEc4ZVE1YzZBWTBld2lnaXdPd002a2cxdnBxc0JpQzc1bkljd2dtWG96dDZv?=
 =?utf-8?B?THhHT0ZJYjIxbUtyTWIwTTRCNnptYWpGalV1U3ZRbzN2VlJ6RnJEd0ZYbm13?=
 =?utf-8?B?Rjk3eiszUVFQOEdqdzhLUWd6c2hSUGg5V2htTUY0cDU0MVk4cE5xazJ4cWtt?=
 =?utf-8?B?SHU1cmlWTVN0QVNrcGFySDNzRDVFWER5dTBuTFcyQ3RXV2pIZ21ZcTlHNi9v?=
 =?utf-8?B?eW1lcFp2WkgvRERieitBbXFMNGJSSWxqOUtsVmZlNmdnbmFqYTRadTdhLzlZ?=
 =?utf-8?B?S3VYVEhIZTBxUU44ZkhPK1lhSEV1dlhkbk9lcmpjclhhaFFIRnNMMkpaK0xH?=
 =?utf-8?B?REZPOHpuMkZZODcxN3JXNmVKZGhwQnpieGRvcGhjRzE1OWpQbVFxVHFHZzJk?=
 =?utf-8?B?TWZoYi81OSt0aThRcmxTekVwRGluRjZveGROY1JaOHN5OFBGQWpsZmdyeTBp?=
 =?utf-8?B?OGxUcWJjUk9yUE1pSmlRdEhIM2dSb1BzZERwWEYva21aWDN2NTRoZUNtelhs?=
 =?utf-8?B?T3krcERSNW1kNHArNzFIMmdGaHpiVXh0RGdXVmdkNHFQNlh5UHJZd3lQeElm?=
 =?utf-8?B?QUVFTDhPY1BIRFJwa1J2TmxYRy9ValhWRXFZRXFiM2FwK1NHcEFyN3k2OXZh?=
 =?utf-8?B?QjJJTlBLd2kzYWpYdmRkOWh4YUd3NnBUUk5wVVVEaDBtSHNVYUx2SWhmQmRY?=
 =?utf-8?B?RFV4eHVPVG10eDM0YW1FMm9iOHlSdzkrYzh6L0ZINENmWHBiVXBWZFl1YU1R?=
 =?utf-8?B?UWlUaUYzaUN4S0laaXZrMlVkVzhiYnlQTWVkNUd4Zy9xczRnSGd3Q0laTWUy?=
 =?utf-8?B?UWtWdWlsZ1Mzc2taMVFJNkFCSVNHckFvQ1dNN0c1NDFmemwwU0VHRW1uOVpk?=
 =?utf-8?B?RU0yc0ZhZ1A0K0p3WXdyNVJYZkU0dHpvOHVva2w3SGhQWFFTbTI3dkVYb2hl?=
 =?utf-8?B?bFRBcWJYZ2Z6bGhZZWpxUVZkczVNTk9SV1ZvOW9uYzdoWW1tdm9acjI5SHBh?=
 =?utf-8?B?L0o1R3ZCTUdlTjF1ZU90YUpHNmV3eTJmajR0QWRPbmFScXBDU2JSeGZIYStO?=
 =?utf-8?B?ZHRJRk9lQzg0cFJObmhSYmxlYU5obXpYYzBxT043blZaUllISzBsVExmK3BX?=
 =?utf-8?B?UGdzWFZqTVBNVGNCK3pDWUpnTnZVenV0MFd4TnVwVFBjeStNSW9qYXBxSVVo?=
 =?utf-8?B?MGdVWHBSanpDcmV1N3lNR002TElFRVNNL04yY0NRZ0FYaGdYSFBpUndNMVpQ?=
 =?utf-8?B?Z3lsY0JHZUk2THRvWk1tdXNjUndsaHhEM2o4SXFiNmM2Tloyc3N6U1F5dkVy?=
 =?utf-8?B?OGZiMjB0eWF1SHJMK1VaUTZ5MkMvK1JDd05TVzlabDJHeG80OGNtcFhLNkI2?=
 =?utf-8?B?NlpFWDlqTFpXVHlMRzVkZ2kvTndZQnh6SGhEV1oyN0dpNGE4a0k4Q0dCNmpw?=
 =?utf-8?B?cFRWbEgvZXRJSVBYcGhUZ01RczJRa09xSHdyZjNvcWNsNE5lODliaUhoc1B5?=
 =?utf-8?Q?VKW403m3vGaZagbU46wHbiqlqpgRrqJfr8ePO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88238795C8658549892ABA90B78CF5EC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4344.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7250d739-c97b-476b-0560-08da1f112bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 18:53:03.6597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+oplJFjkvo1osvnoDmyhfJL8ZacPwzr4RLXbkj8It/l/08duueGMYjk+/bEJISTj6gxbIOkaEl1T/TzDdQUbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3789
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_06:2022-04-15,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=740 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150107
X-Proofpoint-ORIG-GUID: 9oXVniWcGSZ9MEF2Z9fRa-He7CAVFtGB
X-Proofpoint-GUID: 9oXVniWcGSZ9MEF2Z9fRa-He7CAVFtGB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXByIDE1LCAyMDIyLCBhdCAxMjoxNyBQTSwgTmljayBEZXNhdWxuaWVycyA8bmRl
c2F1bG5pZXJzQGdvb2dsZS5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBBcHIgMTUsIDIwMjIg
YXQgNzo1MCBBTSBRaW5nIFpoYW8gPHFpbmcuemhhb0BvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0K
Pj4gSGksIE5pY2ssDQo+PiANCj4+PiBPbiBBcHIgMTQsIDIwMjIsIGF0IDQ6MzAgUE0sIE5pY2sg
RGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPiB3cm90ZToNCj4+PiANCj4+PiBI
aSBRaW5nLCBLZWVzLCBhbmQgQmlsbCwNCj4+PiBKb3NlIGFuZCBJIGFyZSBjdXJyZW50bHkgaW4g
dGhlIHBsYW5uaW5nIHByb2Nlc3MgdG8gcHV0IHRvZ2V0aGVyIGENCj4+PiBLZXJuZWwrVG9vbGNo
YWluIG1pY3JvY29uZmVyZW5jZSB0cmFjayBhdCBMaW51eCBQbHVtYmVycyBDb25mZXJlbmNlDQo+
Pj4gdGhpcyB5ZWFyIChTZXB0IDEyLTE0KSBpbiBEdWJsaW4sIElyZWxhbmQuDQo+Pj4gDQo+Pj4g
V291bGQgeW91IGFsbCBiZSBpbnRlcmVzdGVkIGluIGxlYWRpbmcgYW5vdGhlciBzZXNzaW9uIG9u
DQo+Pj4ga2VybmVsK3Rvb2xjaGFpbiBjb2xsYWJvcmF0aW9uIGZvciBtaXRpZ2F0aW9ucz8gRG8g
eW91IHBsYW4gdG8gYXR0ZW5kDQo+Pj4gcGx1bWJlcnMgdGhpcyB5ZWFyIHdoaWNoIHdpbGwgYmUg
aW4gcGVyc29uPw0KPj4gDQo+PiBJ4oCZZCBsb3ZlIHRvIGF0dGVuZCAgcGx1bWJlcnMgdGhpcyB5
ZWFyIHRvIG1lZXQgcGVvcGxlIGluIHBlcnNvbiENCj4+IEJ1dCBub3Qgc3VyZSB3aGV0aGVyIHRo
ZXJlIHdpbGwgYmUgZW5vdWdoIG5ldywgYmlnIHN0dWZmIHRvIHJlcG9ydCB0aGlzIHllYXIgc2lu
Y2UgbW9zdGx5IGJ1bmNoIG9mIGJ1ZyBmaXhlcyBhbmQgbWlub3INCj4+IEltcHJvdmVtZW50cyB0
byB0aGUgcHJldmlvdXMgd29yay4NCj4gDQo+IE5vIHdvcnJpZXM7IGl0IGRvZXNuJ3QgbmVlZCB0
byBiZSBhIHByZXNlbnRhdGlvbiwgb3IganVzdCBvbmUgcGVyc29uDQo+IHByZXNlbnRpbmcuICBJ
IHRoaW5rIGEgcXVpY2sgcmV2aWV3IG9mIG5ld2x5IGRldmVsb3BlZCBmZWF0dXJlcyBmcm9tDQo+
IHZhcmlvdXMgYXV0aG9ycywgdGhlbiBhIGRpc2N1c3Npb24gd2l0aCBjb25zdW1lcnMgKGtlcm5l
bCBkZXZlbG9wZXJzKQ0KPiB3b3VsZCBiZSBiZW5lZmljaWFsLg0KDQpTb3VuZHMgZ29vZCB0byBt
ZS4NCg0KUWluZw0KPiAtLSANCj4gVGhhbmtzLA0KPiB+TmljayBEZXNhdWxuaWVycw0KDQo=
