Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C79E4959BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378637AbiAUGIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:08:02 -0500
Received: from mail-bn7nam10on2105.outbound.protection.outlook.com ([40.107.92.105]:9472
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348084AbiAUGH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:07:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abDny/z7gdQlWbk+vAi3362Nelmg19FCLaVUFS0g5MuH4JvweLMBUSNahRxV2rvuSzh4OdPvexqu3CZW54ldLu0Xe7fzH5t/KGP2r7P0bBVSlUJxCGOFuQHvltK2h6D+sRs0C+H0bNy/XdMzFvFrthnbDwP6xi0CU1VNWe+2PdBAfFClyuLiqm/bh5vLoUqYps5d0XKaC334UiohJ1isV8e7K+j5jlHHuKkB1bYy/ffhcCrov5s4fxJeFka0R25+FsEsblzu8PDHpiwmNmJSy1gjyDqLeBmSxYfL7iOeuvmXx+MvT4HspbhNXjiQ+CbRO13ZOOHzohiglc5YBATB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4r2hJx/ePC/3kXJAWBxbVBUMAiIlxON1WA1HGuqijw=;
 b=K27HXORQOzp52rgWJt71/Rj897XvaPwQsNbhuTDm44hzeVpS21Ba7NGlFJ7/MsTOSMYT1wg6P91q/0j8zvK7mOgd7yXk0RbU+UF9uBaeeWWqnjZK/IcDQOy3ZdtXMkgZK9BQdkrUM3a/pkNe670utw7KVncQL5HufdvtC8onpRPhy1cVbYxs/2NmbiVJ1pk9psiR1Pzei78OgNc7Pxjzy9rza+TsfPrMJkwHDpl/DKrN02LL0c8d/UzR6FtxGSSfPaLGVTUD36qnfjd3NWo7VyWzn6E7Weku8+p71A4i77YzUTfZupmO4k6PAMsDWq2SqtFFfJfl2of8M3j32FLfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4r2hJx/ePC/3kXJAWBxbVBUMAiIlxON1WA1HGuqijw=;
 b=n9iXqDYF1pQJaKGDO1Us4458niF45fC8ARX6KGCmS/+d39nwESML3Cp9IbBX3ROqIAKWDXmRjPnj9S3/HgopIcrLA+J/eRDvZmoiftmgCUDnEh6anwFy+tnZVi3g4jWRGh5d55usnMjk77irrKwCOOdNR54jMEDVwDpXdN4csOE=
Received: from PH0PR16MB4248.namprd16.prod.outlook.com (2603:10b6:510:4c::16)
 by DM5PR16MB1578.namprd16.prod.outlook.com (2603:10b6:3:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 06:07:54 +0000
Received: from PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::e88f:f199:eed:4645]) by PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::e88f:f199:eed:4645%7]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 06:07:54 +0000
From:   "Chevron Li (WH)" <chevron.li@bayhubtech.com>
To:     "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Shirley Her(SC)" <shirley.her@bayhubtech.com>,
        "Fred Ai(WH)" <fred.ai@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Bruce Yang (SH)" <bruce.yang@bayhubtech.com>
Subject: =?gb2312?B?s7e72DogW1BBVENIIDEvMl0gbW1jOnNkaGNpLW1zbTpmaXggUXVhbGNvbW0g?=
 =?gb2312?Q?sd_host_7180_SD_card_compatibility_issue?=
Thread-Topic: [PATCH 1/2] mmc:sdhci-msm:fix Qualcomm sd host 7180 SD card
 compatibility issue
Thread-Index: AQHYDo06oWtvqqxIIE+azh4I2AQx0w==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Fri, 21 Jan 2022 06:07:54 +0000
Message-ID: <PH0PR16MB424847C2663074785BB735ECEA5B9@PH0PR16MB4248.namprd16.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2a59df0-4239-4bd0-e6d6-08d9dca45d35
x-ms-traffictypediagnostic: DM5PR16MB1578:EE_
x-microsoft-antispam-prvs: <DM5PR16MB157892A68073DAAC0D091E78EA5B9@DM5PR16MB1578.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4WRBNiPuBEkVHsFEjIS1+r8u8lCX0JxyCC65G79iGj/xvJ5TpQGeJ4y5ChjNq8eLC6sfHwAS8apT3Z2KqvWJNeWp7nDxRizGkz9N7fQJyzHAyCAxOqMNgIN35cuzGujZg+eCGbe7gFloQbwNAV3ccmiyKX7GVyo1Ph+udvli0xscHukyTASDDtmk7ws4VBrQVsKSU53Ya9OQEu5wvaS4N21vLMYJqxA4ZytmzQUQrlWqd9ICUMGxbJAkXFBHClte/LLceK+O7jj7sEx/Q6mbdTtHrsB8Ey9LPUQJXKcA8yALNVEOKH66dcNKG+TQmMv8UBMc+IdIX3SMrt9m5tlJQTe1pI+XLLXKHxzw+xAKMRkmcTXIs9+M7wNn3LZBYpUnYM9IFueRf2TarEuakz7E9C8oTJncPivoTy8qQnKIOKS9NPOFaiBy/lggOwzFUdYlraVVPHUpQB9F6yS9mh58gW5HChDKEYR9ZkYBdUzgYMp6qsvZedVJlC58AZ6aaYu82SntuUNUkR32f8NgfxC7Y8I9+9QWDt2ZbYlJuSoIhfEXK/77O1cEUBQPj0edVNzFuUawA5jOy8ROyLH5h0Eo/6TBDrfQe22LIbdSDlWlRbtRlWnba7OiWqsuL6Y0nHeI6Q5Ma2hfH+BCK6DHLMffQiHrJnXs0ldtI1AikpjwAmWgpwgqNL4dQUVLQTsQ6sj3eWXsczn8+PUZXQdoWOpTZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR16MB4248.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39830400003)(366004)(346002)(136003)(66556008)(55016003)(66476007)(33656002)(64756008)(8936002)(66446008)(71200400001)(6506007)(7696005)(508600001)(86362001)(76116006)(4326008)(66946007)(26005)(2906002)(186003)(9686003)(558084003)(54906003)(122000001)(110136005)(5660300002)(38070700005)(38100700002)(316002)(52536014)(107886003)(224303003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YmY3M1NTQ05teGx4RkhWWTJrSVUrWVNKUjh1ekhZVHhyYkNlL3UwcExvVUdN?=
 =?gb2312?B?a3pPbEp6WFVuUmx2RUROMzM4bmNYYjFpaE96YWtTbUkyOUNoeWEraW9CNi9N?=
 =?gb2312?B?aTFFeHAvMjhPL01PSWRtSTYvcjgrckk0M1I3NlVSUDJBRU51S1E4TnRRRFJk?=
 =?gb2312?B?THNyYXEzY25YQ0xXc2pDRnVBZ0tRNzdzUlh3Mkl1amdhenR1NTFVeFlJeE9S?=
 =?gb2312?B?dkRSMmEzVUJOeWpjbHlqOEwrNExIWnRvZzhaWk1tZzVIZml1cDR4UXlwZUxy?=
 =?gb2312?B?d2pwN1M5WUI5Q3orMjAwZzF4eUozd2ladHlONEFwano4czB5ZmMzYzFKcjEw?=
 =?gb2312?B?b09uWXFBM0pIOHQzOVh0OFlyeU9Kcm9ZKzE2SmVVQ0IwMFc1ZjBab0RkaTgz?=
 =?gb2312?B?WjFPNUM0NjE5clpXUERxN0ZIdHNJMlNveFdKT28rektsVHgvVmVKdHBjK1l5?=
 =?gb2312?B?QWhiK0lCallsWUJtT0hESG43YlFmV2FLR2hKc2dpZi9vMkNybURKb3BlZk95?=
 =?gb2312?B?UjkybHBvb3ljT1prVDVJb3hiRncyZXV5WmdtMDhBdVJrRnRnakFhd1dkQnVl?=
 =?gb2312?B?L3QzL1huRTNCbUtscG53RSt0a0YyOG5ub1pDVithQTJpbXJWdlJFd1plVEd5?=
 =?gb2312?B?RGtLTlYvd2YrOXZDVEFneDlQb0JFYW54YmlDb3pwTFFLZnhrOXpKS1hnMTEz?=
 =?gb2312?B?eXhGMHJnSzVDRW9UckR1VG9TMjA3WUxVcksyMm8xeDV2QlNYclJPSGpaMTRp?=
 =?gb2312?B?UStmVDl4RklMdWd6TUVUWlA0d2djYll3cWhGdHk0MmZ3aS9RdlpDWTEwMUhj?=
 =?gb2312?B?ZDFRZkI1RDlRSk9OSktDVmY1NmQ2dUFTYXQwa1QzQU55Y1YvNzhzRll4eG9T?=
 =?gb2312?B?dGVwNWhjNlRlS0MvaFZPWkdVelpkbHlqMnhjZnNoSTJWaE9GL3lVbDhRZkx5?=
 =?gb2312?B?ajZxMTNuOGVaSjF5WUZ6Y3JxYTlGVjRURDdYODlqbWtDSDFVSzAvTXpLVisz?=
 =?gb2312?B?c3ZLcHpuNmF5RG1LSXZKUDNhOU50VFhEY1lZdmtLd0lqNmwrRUp4SHVqc1FI?=
 =?gb2312?B?d2l6ZE9DQklSUmFMOE9ac3FPQUhuSUl0c1ppWm5OaGgwRFY2NmIyQlMza01Y?=
 =?gb2312?B?Yk5vNVR4VVFLRFZHWkpYcGxuT2kweHlkRjZHMVQ4bk01UGNWSTJCOVY1VW14?=
 =?gb2312?B?djVRRUEwTkVkZENXTzJlUU9STTBJcUNsSjJCSlR0WVRwM2VSSTNTQjNab1ly?=
 =?gb2312?B?Z21yVGxXUlJweVVYbEl2QWFPQmliK1dQem1FZk5hbDNFMHJPeEVtNXlLNWpR?=
 =?gb2312?B?c2diTFJEdzViRGxmTXNTdUtGbC9Cc2o5bHcyWUtCdWRXN3pnaklZNEg3Vm1G?=
 =?gb2312?B?TkpXaDQ2L2k2QW9qUjlGTVJoOTJUU2JJTFVLSmdsT2NUWW1kZnIzOE1hTWNK?=
 =?gb2312?B?cktsUXErSEtBSElQUkxJQm54U1V5OXBVQnlKaDF2WlVYNVhCN1dIc3NtaDJG?=
 =?gb2312?B?R1BnMnVJVEVUM3h1ekJtR1crS0JHUlRZZVFuK1c3ZTBURFRnWHRYclh6T3do?=
 =?gb2312?B?NjA4SE1sNW85a0hXYVdZTGk5cGlyVGJtVU5FZ1FCYUpJZDlrVjFUWWh2bEZD?=
 =?gb2312?B?YU5Wb0hxZ054cWNvOStRMmg1U0V3eFlaUXhheXVlZ3ZGWTBOa3pCdThmdUV3?=
 =?gb2312?B?c29HOXB2dnduTGs0eVBCOE4zM3BBTmZZNW1oQjUzMHJJalcwd1RNQWp6OEt6?=
 =?gb2312?B?ajZHbmpMRWVhNXk5S21CYmlDL2tqR1NTSlN3RjluVUl0WXFIYzRrWnB4c0JD?=
 =?gb2312?B?MnFkTzR5bno0am40RE1qdndGUWVacG1ySzlkRTVGZDdzcmNhS3hQMGY2OGJy?=
 =?gb2312?B?N2I3NjcwS3RIR3c1QlNwSjRPa3RsL2s0Nmg0N1c5cVlxK1NWcXhXK1NONHls?=
 =?gb2312?B?K1ZDeDdEVEJXTFh2RmJiSktndjIzR1Y4ZUFlcit0MVBTWnNnRTE0VzFRZXgr?=
 =?gb2312?B?U0x6T0xmZS9qMU9sWm85UXFhRlY1ZHJDaVdGeGI4b3lwM1RwSXpnYzgyTE92?=
 =?gb2312?B?cXk4RDBPV0xnSnJ5TnA0NGtuT3VDQTBkUWRvbVhkS3JuYm9IbXVOcnpNY3pk?=
 =?gb2312?B?VG1ZcmxGZksvMmRtY0lvQUhmYkdDT0tVK3BPN2FpdTY1Sno0QkFhZEJjaWxI?=
 =?gb2312?B?WnRham1RajBrdFZpQUZ0dW5Zc3MyVHJVZUVnMHRaUW8yTDdwemtYUk5WUEUv?=
 =?gb2312?B?OUxHWkFucy9EeUxNYkdiYzFSNmN3PT0=?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR16MB4248.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a59df0-4239-4bd0-e6d6-08d9dca45d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 06:07:54.4322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JyDA/1dvOttJJ766mJACUFACiOhjy/m4K+tH/n6ztU2ErkAeGhR1XMCdnbWBlj9Dl3o1YnQxkAI5TWfg1a75pZRuk3mdAcoHgvq+5LRRO0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR16MB1578
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hldnJvbiBMaSAoV0gpIL2rs7e72NPKvP6hsFtQQVRDSCAxLzJdIG1tYzpzZGhjaS1tc206Zml4
IFF1YWxjb21tIHNkIGhvc3QgNzE4MCBTRCBjYXJkIGNvbXBhdGliaWxpdHkgaXNzdWWhsaGj
