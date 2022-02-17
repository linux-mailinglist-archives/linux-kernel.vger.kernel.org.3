Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492434BA3E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbiBQPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:00:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbiBQPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:00:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DBA63B9;
        Thu, 17 Feb 2022 07:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645110017; x=1676646017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I/3dnDjr2anLxsOejUT1utxyo124l/3uw3WPb1Hs/uY=;
  b=YpVRzjlRfTYpYmA6XecANQ5Jka9+1S0f/7DsKKmM3TJRG5K61hjQENMo
   q0qHx+M7NYwCBF28xM6+Nw955OnH8merYaVX2bCuhrvptL7GkiXFPabIK
   tUoOlE7DX99CJh65WscH9MaXiYlzfn6OaMpPKO3TC8GErw+/yTZaVGFOS
   5E6tUZPXSA+LXAjB2VsnEH5Ik55PLrRDw9lYdemOfXclgoXPfHYCukhwt
   g1M/mS6X6vIBGKG/htcSr3KEb1xKOJhGUmdytX5hVqKGnmK4bGvc+vYpY
   uEYyI3wLjMDF6bsbKEQS38khks1M3QrlRUhB2XHwcQIgfFmZ+aNCvhY9V
   Q==;
IronPort-SDR: tGrrxOrk4JMv38tXYfoTx44KCTYu44zCPdFIR9j6fwJckiB6oWvUUW6YMTuexz0Ktb5pWLtDhV
 zn8pwGwXvtB0tE3XiL/lR74i5wvwP7diDiEbnD2k6+khWVBEdvu2EX4S4woByautJYiz7DdCEm
 hchjG03bpZ8jcbG7nBXVuPlXgPQqI5XNgZW8WZ1LTrHbSh3CxKGqQt+D1oyDycwccWtTIKb7+F
 BnXaPpiEGGGJXGDJ345rdinZff4rgIQyiTXZw60/AkHKt1chU8SPPTSufQbA9MiGQk2mAiK6JV
 cusrxoN9Xvdc6fPjUW+C8lh7
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="153438062"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 07:59:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 07:59:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 07:59:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyQmJ/cnv/EDNabpjNvWFrc7To4UExJBg5BorMr1zIuUk5+UGOMG7i4WpjIb7vLnAu2Nq5FVc8ZSrdvsQolJZmC9WkvHBnjonN2c1FssanqbBhjWtIMAvoNIXTmjTSa1ljbyhzmpgdovYEn9bnkcpFRaFsuS7LuZ9+u4160bNa8aCNHnlifJegXwmvlMa4123K1l4XdhWPJtBMREJ0s8HZ2yvnX9DlddHf0L6itFZ4H8plb66J1ySZxxWqGnchbWiLVSXKsDC68dxJEZJt84xsHNuXJR6mWLtoDfCy9qH0jiQdEnPyxCwQL1UXt+J/jvpwuiV9VEoTwFNO1xAMeRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/3dnDjr2anLxsOejUT1utxyo124l/3uw3WPb1Hs/uY=;
 b=h38AOcPVLzKCEQwhwtIq3dX9/wRxKnkzKZphimfiYiObOZjaP18/IXrrmPj2bk41ebJsK363aO+QtRHk1mkdbw8cfxcgGbSUq43xgGGmvr5KCW60Tgesojak2YnxC+aEw58UbQ4/CR4vTAnw8vNLJzMQyryPlZ+YqkDYid2wnPu68sL9T3pZZNgvOS7ATLqrc1Fx8z06IhVHQq87ip5XM2i5hM9+wVfkVu49bSlArj0Dqgo6FSp5AOFnv0FE+UvDKDGbnf7ypQFW+DF2/jobtmjc4njbaMX19RUA8kMXQKIs4I7WD6N1nsw1+VWcwVhe67nx2kDHGJzu9zELRROkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/3dnDjr2anLxsOejUT1utxyo124l/3uw3WPb1Hs/uY=;
 b=scj+hmN4YBo8dYDIhkElT9D5ePm6h57xWscSrJyQCSqMIFje+p2zcAug0ezue7/YSELLP98PJR0sm5Hdrum8PL75Q6TMg+q37FlIa+2mHq4sOf3NDUFQln9+EUBA/pIqM4neV8O2qBhn78efbTJnqr7GY26vAXet3oCKzWqruRE=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by CY4PR11MB1943.namprd11.prod.outlook.com (2603:10b6:903:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Thu, 17 Feb
 2022 14:59:20 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::11a5:42e0:3f3d:fcdc]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::11a5:42e0:3f3d:fcdc%9]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 14:59:19 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>,
        <hverkuil-cisco@xs4all.nl>, <Nicolas.Ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v5 04/13] media: atmel: atmel-isc: implement media
 controller
Thread-Topic: [PATCH v5 04/13] media: atmel: atmel-isc: implement media
 controller
Thread-Index: AQHYJAZ+RxoDWk5/90CKPirCgjVVNKyX1dAA
Date:   Thu, 17 Feb 2022 14:59:19 +0000
Message-ID: <e4109e0f-af1f-7594-a154-92e65fd7ac59@microchip.com>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
 <20220217135645.1427466-5-eugen.hristev@microchip.com>
In-Reply-To: <20220217135645.1427466-5-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76f1b1ba-182f-4b52-f710-08d9f2261375
x-ms-traffictypediagnostic: CY4PR11MB1943:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1943EBD07991CC9CAC3C1C5DE8369@CY4PR11MB1943.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8BmT8Vovajvv4k2Y3PzWqEOAn8AYirv4S4QYAnm8Jf4GyFv9XKxZZti5qTv8vNV9bvQI6KrPBB6n068MKa/Q7QF+5WzNEzS2a9M3L4Nk+RYgrdcVExmL45Al6BsGoO8xSU3r/RYY+8c3I/kmghMgx3Bv6kSt5C80I+Uwrl5v+PB0CKD7xQWpkqYXvjej9afeuMUc8XVbcH9NX25SsMebg2hOox/uryDGrNdc9A8USqNNbTivXvk6IGfSi+n99cxLGZVySF1KTtv4ZN41V+GB8t1rvvNIOCPawFTMS31p+wXC7kprP/LwR5FFpRtyV1GHGDAF4ERzDA5poHBoxDFiW/fAxW1aKSaojVk+H11ty89cXZ4rlXG+O4uRnJ3u0IcWAPYnoru0xKgiaErRnUEjMwX5T2JZmJzIl4Tu3lZ8bejGd6H0lPW4bc/CcFG0AG/t7SZplcNw/E8ZLHxReQ0pGGypSxgDQciU2NhEQCUEhUBRU0/znKNeq8srRRFjUJRunvUDOspJOIi8ANBvf4GHIBfIwbp8KgqDHZxve2jZHUkNbnLdDSIszHDHAaofDdk1lAue8EVuhbe4sP0aZMoIgCxUrqxH3fJTdR7lRtlQmDjcJukzayYP3+9l/vFhbl52mlI1hkyWe1ByvCDg0SgE13FdLRzMa/I0y9q2GTnd9BzHX47WH3fE0eANxsowY9en1uXcEsE0XWJIVSK40CUDzN2chxtvNpNRDKacSOVTmjAaVxGKosHuTL+DqROJfEZ/Sccpr30kggt7V5pkzCKDWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(6512007)(2906002)(53546011)(83380400001)(6506007)(2616005)(508600001)(66946007)(26005)(186003)(38070700005)(8676002)(36756003)(91956017)(86362001)(64756008)(4326008)(66446008)(54906003)(8936002)(110136005)(31696002)(6486002)(6636002)(76116006)(66556008)(71200400001)(316002)(38100700002)(5660300002)(31686004)(66476007)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a25nbmFDTkJvSFppWkptdDlpTDhRN3J5NTh1NDhLeHRobG5FODBDYTBuTXVX?=
 =?utf-8?B?VFkyM25OSk9MQXZEdHRFbHJyQmhnUWJlRldqeWkrL2lTeHZUcjRIcjlnZVgv?=
 =?utf-8?B?aVl5SGtNLzIvSHpOWkg3VkkveEh6VHlVbkJCU0RmTENBSGUvVlNudStDNDY3?=
 =?utf-8?B?bzh0ODlzMjNES3lBc2RYQ2s1czdjN2VKdHprUlZmbmZna0lzOXE5S2dBRHMy?=
 =?utf-8?B?QkhkRFc2bkZMNmNqUjNKR3VxRzZva21aSVlTUktzRU9oL0lnNkVqN3BuNDdL?=
 =?utf-8?B?MW5CWmtpNGU1WWpLYytNRVVpc0lUWE15SjlRSUJJNmlrbkdXK1htaHVoMnlB?=
 =?utf-8?B?U1VhL21RN3l0dE9YQmhJaWNHdW02V1grekQzQVUvS0F2MkZFM1dFOVVRelBx?=
 =?utf-8?B?d0tjWFJ4V1F5ZUlTZWVVS1FYRlhBdEdWR1c0alNxc1h5bEhSb3QySktKdDJ0?=
 =?utf-8?B?YmtvUmdUL2c5T0V5L2VZZzRQdkl1OGE5RzVVZVNDekNxY1Zua2RvYmJwOFZ6?=
 =?utf-8?B?MGR6QUFiNVdhaFJOdzFWMEFVazBYQm44dDNFQnNheDk1dmdYK3A0SERmaTY4?=
 =?utf-8?B?d2E5WkZQZlA1RnNUSHJBYzNxZGZ4c0lCS1c1UG9RSklVZWNCQkdrUzZWYk1r?=
 =?utf-8?B?d2hKTnVUUEhvRzJzYlRSdldoMHhnbnMvNEVyd0h1NEZDanZNcUlTZTBkZGFF?=
 =?utf-8?B?SEJ6MjZ4dSt6OTlxYUxlajk3UzFoK1p0cDhpQXBNYWhPdlZCWEVsWkI0cmli?=
 =?utf-8?B?ekhMYTh1UVBZelZFU0ZVK1k3SFY3K0pxVjRoSGo2aVhDUHVEQ3BDaVVrRjRy?=
 =?utf-8?B?djRuNmhBRWpjTmdFdTlwV3F6RG1YVXc2Wk94RHV3M2tmM1VPVEtnaW9hVXA4?=
 =?utf-8?B?UVBydE55cUdSZ2lVQzd0bGZaTklFekswUjZtYlZaWFJpaGdsZW1FM3I3MW4v?=
 =?utf-8?B?Ti9RYWVRclFSbVE4N2IzU3M4NU8wTU9rME1TbmdYV1phWHg5WWNTTFZzN3BV?=
 =?utf-8?B?cmt4TjdkTWdCUFgyM3Q0R0ZQKzBDRkt6ZmNRMjN2enB5eHpGZStobXBiU3Jw?=
 =?utf-8?B?RVc4ZDBYeGM1YkE5VHEyYU5CTGZhMEtIZUhYQVFCbFI5b2YrY1FEUUZxN2oz?=
 =?utf-8?B?M1JHK3E1Z3diSU9UMldpSlNDME0vTm1oV0pjVW5MMmtxcVJHOFhUSmQwczJY?=
 =?utf-8?B?WnptV1VxTjIyY2R5UzhPYzd1S2FOSHFGSDhpL3NUdDVCdFVJSkozeWdIYysx?=
 =?utf-8?B?TjJNeW9tTGNGTXZJdlpEbEdKUkFYRUZ0TXJyZ2s3UnJMa2ozdytWbG9DMkdD?=
 =?utf-8?B?K05YQmlqVTdpMjVVelVkQ21weUEwejFEYmxxK2FDbWNYbkpGbm8xbFpYQ1Zi?=
 =?utf-8?B?WmY0dUQzVGdvYzJYM1JJdzF3ejJ0NU9NTThKcjlIZ2t5a08xV0h6cXp1Q1BM?=
 =?utf-8?B?bmxYR3I5UTZkbkFSOWI3dVdDMHpCWjlwK3ZkMWZobGRyc0R3eGRTUXM2anhM?=
 =?utf-8?B?S1NsNkVPRlhOTUM3SWFpQTZvT0lWYzFJRDJuVzl4TUhZTTU4TUd2Y2VoWDMw?=
 =?utf-8?B?YXI4YUl4Z2hYV2FLVGlQejhNeEx3TFh4WUdkMkU2NG9SZTEvdkFoUG12dEhx?=
 =?utf-8?B?aHA5ZXdpdnlZTXAzZVJaUFRtQUl2S2QzdGxBYlhJU3EzUityZDVZOFJsY3B3?=
 =?utf-8?B?UTNEeUpOWVN4Nm9nK1RXY0JqcktuUzYwQXJEWndCVXhuYXlHTC9DUkxkOUV3?=
 =?utf-8?B?UzlyVHNkSzFaRGlIdFkrYld3TUxMVXBVU2xIVWROblVFSkNzYTdPYVhyL1Nl?=
 =?utf-8?B?MWFFa0QvS0laTDlqOVlnVm4yQjBIV041NjRKQ3pGdGZXaGxiYTdaNWdLT01p?=
 =?utf-8?B?UEhLMmZzZnZnZ1BWL2ZmdlUxeW5NelZGS3l2bFJiQXhkSCtjYStIWkVCUjAr?=
 =?utf-8?B?WG15cDVNM1VIcTBPUS94dWpRSmM0aEdzYmpGSFBLL2FqYTZvbXlLdjQ3d2VF?=
 =?utf-8?B?K0dDenBpMisxRmpuSFJWaTNhSGxleVdhYUl6MzlDV0VYdDM0d1FPT3FtNGE0?=
 =?utf-8?B?TzhGQnJOcS85anZIK1RrSlN2ZnZBTUZMeXRDOU40R3hqMC9vN01LK0FEOEwx?=
 =?utf-8?B?bFdpek9PbmJpSndKZ0FFRDBqcnErRTQ5d1U1ZytNQXgrRUZvYjR5NDBqNkcz?=
 =?utf-8?B?c1RubUNBOUhveXBWUEhWbkVMRUQ1TzFqME5QdGJiSk9ZUTQ2dUMwdmMvSFNI?=
 =?utf-8?B?MklkeU5xekMyNHUwNWl6RU8zbFhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C7CDF3DE2022A45AE7CF16EC338F809@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f1b1ba-182f-4b52-f710-08d9f2261375
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 14:59:19.7719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uj2nLcDIlY5k04hcHjPUVJQdtD3L/Wo6HbTjc8dOKLEO083Nu+YhjzItbuCA74JQYq6hB1gBBA5zEsK1GH1tbjSJqlFmGbwY6WPu2tUvqQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1943
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xNy8yMiAzOjU2IFBNLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPiBJbXBsZW1lbnQgdGhl
IHN1cHBvcnQgZm9yIG1lZGlhLWNvbnRyb2xsZXIuDQo+IFRoaXMgbWVhbnMgdGhhdCB0aGUgY2Fw
YWJpbGl0aWVzIG9mIHRoZSBkcml2ZXIgaGF2ZSBjaGFuZ2VkIGFuZCBub3cNCj4gaXQgYWxzbyBh
ZHZlcnRpc2VzIHRoZSBJT19NQyAuDQo+IFRoZSBkcml2ZXIgd2lsbCByZWdpc3RlciBpdCdzIG1l
ZGlhIGRldmljZSwgYW5kIGFkZCB0aGUgdmlkZW8gZW50aXR5IHRvIHRoaXMNCj4gbWVkaWEgZGV2
aWNlLiBUaGUgc3ViZGV2aWNlcyBhcmUgcmVnaXN0ZXJlZCB0byB0aGUgc2FtZSBtZWRpYSBkZXZp
Y2UuDQo+IFRoZSBJU0Mgd2lsbCBoYXZlIGEgYmFzZSBlbnRpdHkgd2hpY2ggaXMgYXV0by1kZXRl
Y3RlZCBhcyBhdG1lbF9pc2NfYmFzZS4NCj4gSXQgd2lsbCBhbHNvIHJlZ2lzdGVyIGEgc3ViZGV2
aWNlIHRoYXQgYWxsb3dzIGNyb3BwaW5nIG9mIHRoZSBpbmNvbWluZyBmcmFtZQ0KPiB0byB0aGUg
bWF4aW11bSBmcmFtZSBzaXplIHN1cHBvcnRlZCBieSB0aGUgSVNDLg0KPiBUaGUgSVNDIHdpbGwg
Y3JlYXRlIGEgbGluayBiZXR3ZWVuIHRoZSBzdWJkZXZpY2UgdGhhdCBpcyBhc3luY2hyb25vdXNs
eQ0KPiByZWdpc3RlcmVkIGFuZCB0aGUgYXRtZWxfaXNjX3NjYWxlciBlbnRpdHkuDQo+IFRoZW4s
IHRoZSBhdG1lbF9pc2Nfc2NhbGVyIGFuZCBhdG1lbF9pc2NfYmFzZSBhcmUgY29ubmVjdGVkIHRo
cm91Z2ggYW5vdGhlcg0KPiBsaW5rLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRXVnZW4gSHJpc3Rl
diA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCg0KDQpIZWxsbyBKYWNvcG8s
DQoNCkkgd2lsbCBhZGQgdG8gdGhpcyBwYXRjaCBhIGxpdHRsZSB1cGRhdGUgYWJvdXQgaG93IHRo
ZSBzY2FsZXIgaXMgc2VlbiANCm5vdyBieSB0aGUgbWVkaWEtY3RsIDoNCg0KZm9yIGlteDIxOSBz
ZW5zb3IsIHdoaWNoIGdlbmVyYXRlcyAzMjgweDI0NjQ6DQoNCg0KLSBlbnRpdHkgMTogYXRtZWxf
aXNjX3NjYWxlciAoMiBwYWRzLCAyIGxpbmtzKQ0KICAgICAgICAgICAgIHR5cGUgVjRMMiBzdWJk
ZXYgc3VidHlwZSBVbmtub3duIGZsYWdzIDANCiAgICAgICAgICAgICBkZXZpY2Ugbm9kZSBuYW1l
IC9kZXYvdjRsLXN1YmRldjANCiAgICAgICAgIHBhZDA6IFNpbmsNCiAgICAgICAgICAgICAgICAg
W2ZtdDpTUkdHQjEwXzFYMTAvMzI4MHgyNDY0IGZpZWxkOm5vbmUgY29sb3JzcGFjZTpzcmdiDQog
ICAgICAgICAgICAgICAgICBjcm9wLmJvdW5kczooMCwwKS8zMjgweDI0NjQNCiAgICAgICAgICAg
ICAgICAgIGNyb3A6KDAsMCkvMzI2NHgyNDY0XQ0KICAgICAgICAgICAgICAgICA8LSAiY3NpMmRj
IjoxIFtFTkFCTEVELElNTVVUQUJMRV0NCiAgICAgICAgIHBhZDE6IFNvdXJjZQ0KICAgICAgICAg
ICAgICAgICBbZm10OlNSR0dCMTBfMVgxMC8zMjY0eDI0NjQgZmllbGQ6bm9uZSBjb2xvcnNwYWNl
OnNyZ2JdDQogICAgICAgICAgICAgICAgIC0+ICJhdG1lbF9pc2NfY29tbW9uIjowIFtFTkFCTEVE
LElNTVVUQUJMRV0NCg0KDQpUaGUgc291cmNlIHBhZCBvZiB0aGUgc2NhbGVyIGxvb2tzIGdvb2Qg
bm93Lg0KDQpGb3IgdGhlIGlteDI3NCB3aGljaCBJIGFtIHVzaW5nIChhbmQgaXQgZ2VuZXJhdGVz
IDM4NDB4MjE2MCApOg0KDQotIGVudGl0eSAxOiBhdG1lbF9pc2Nfc2NhbGVyICgyIHBhZHMsIDIg
bGlua3MpDQogICAgICAgICAgICAgdHlwZSBWNEwyIHN1YmRldiBzdWJ0eXBlIFVua25vd24gZmxh
Z3MgMA0KICAgICAgICAgICAgIGRldmljZSBub2RlIG5hbWUgL2Rldi92NGwtc3ViZGV2MA0KICAg
ICAgICAgcGFkMDogU2luaw0KICAgICAgICAgICAgICAgICBbZm10OlNSR0dCMTBfMVgxMC8zODQw
eDIxNjAgZmllbGQ6bm9uZSBjb2xvcnNwYWNlOnNyZ2INCiAgICAgICAgICAgICAgICAgIGNyb3Au
Ym91bmRzOigwLDApLzM4NDB4MjE2MA0KICAgICAgICAgICAgICAgICAgY3JvcDooMCwwKS8zMjY0
eDIxNjBdDQogICAgICAgICAgICAgICAgIDwtICJjc2kyZGMiOjEgW0VOQUJMRUQsSU1NVVRBQkxF
XQ0KICAgICAgICAgcGFkMTogU291cmNlDQogICAgICAgICAgICAgICAgIFtmbXQ6U1JHR0IxMF8x
WDEwLzMyNjR4MjE2MCBmaWVsZDpub25lIGNvbG9yc3BhY2U6c3JnYl0NCiAgICAgICAgICAgICAg
ICAgLT4gImF0bWVsX2lzY19jb21tb24iOjAgW0VOQUJMRUQsSU1NVVRBQkxFXQ0KDQpTbyBpbiBi
b3RoIGNhc2VzLCBlYWNoIGxpbmUgaXMgY3JvcHBlZCBkb3duIHRvIDMyNjQgYXMgdGhlIG1heGlt
dW0gd2lkdGguDQoNCklmIHdlIHNlbGVjdCBhIGxvd2VyIGZyYW1lIHNpemUsIHRoZSBzY2FsZXIg
d2lsbCBhdXRvbWF0aWNhbGx5IHVwZGF0ZSANCnRoZSBzb3VyY2UgcGFkIHRvIHJlZmxlY3QgdGhp
cywgZS5nLjoNCg0KDQotIGVudGl0eSAxOiBhdG1lbF9pc2Nfc2NhbGVyICgyIHBhZHMsIDIgbGlu
a3MpDQogICAgICAgICAgICAgdHlwZSBWNEwyIHN1YmRldiBzdWJ0eXBlIFVua25vd24gZmxhZ3Mg
MA0KICAgICAgICAgICAgIGRldmljZSBub2RlIG5hbWUgL2Rldi92NGwtc3ViZGV2MA0KICAgICAg
ICAgcGFkMDogU2luaw0KICAgICAgICAgICAgICAgICBbZm10OlNSR0dCMTBfMVgxMC8xOTIweDEw
ODAgZmllbGQ6bm9uZSBjb2xvcnNwYWNlOnNyZ2INCiAgICAgICAgICAgICAgICAgIGNyb3AuYm91
bmRzOigwLDApLzE5MjB4MTA4MA0KICAgICAgICAgICAgICAgICAgY3JvcDooMCwwKS8xOTIweDEw
ODBdDQogICAgICAgICAgICAgICAgIDwtICJjc2kyZGMiOjEgW0VOQUJMRUQsSU1NVVRBQkxFXQ0K
ICAgICAgICAgcGFkMTogU291cmNlDQogICAgICAgICAgICAgICAgIFtmbXQ6U1JHR0IxMF8xWDEw
LzE5MjB4MTA4MCBmaWVsZDpub25lIGNvbG9yc3BhY2U6c3JnYl0NCiAgICAgICAgICAgICAgICAg
LT4gImF0bWVsX2lzY19jb21tb24iOjAgW0VOQUJMRUQsSU1NVVRBQkxFXQ0KDQoNCmRvZXMgaXQg
bG9vayBnb29kIG5vdyA/DQoNClRoYW5rcyBmb3IgY2hlY2tpbmcgdGhpcyBvdXQgIQ0KRXVnZW4N
Cg==
