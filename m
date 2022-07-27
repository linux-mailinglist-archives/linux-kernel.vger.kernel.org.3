Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368695829D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiG0Pmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiG0Pmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:42:51 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912EBBF5E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1658936570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tPfBYACwUw/V8DzgjfYnPeUUskCCCURJ9k4kfqMQBFI=;
  b=Ol5SOqWSG1HVI4TpWBV0ZLZlH7dNVCR3IFXpiqSTmKN8FS8V9iG+IA3w
   dWd/IOgviW1y5S23z8vF/7TVDr7kPcmdsjhAByKGWW5oGFAsqTOeklMEw
   Ov008x9nNL4n+HKkox7Pk7ymf3NmarVtdRzpNmAjjJxDrKZFxLWkXgy8w
   k=;
X-IronPort-RemoteIP: 104.47.66.43
X-IronPort-MID: 79322944
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:ob9V5K4E8W5tVW55mk+PoAxRtBXHchMFZxGqfqrLsTDasY5as4F+v
 mIdCmjVbPiCM2P9et9xYIW08EIPvsTXm4dnTgM5qn8yHi5G8cbLO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG96yM6jclkf5KkYMbcICd9WAR4fykojBNnioYRj5VhxNO0GGthg
 /uryyHkEALjimUc3l48sfrZ8ksw5quq4Vv0g3RlDRx1lA6G/5UqJMp3yZGZdxPQXoRSF+imc
 OfPpJnRErTxpkpF5nuNy94XQ2VSKlLgFVHmZkl+AsBOtiNqtC0qupvXAdJHAathZ5dlqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJHtxBoMX2cdFOjkQ3
 voeLGlTUAuSoP3jldpXSsE07igiBO/CGdpF/1Rfl3TeB/tgRo3fSaLX49MexC03ms1FAffZY
 YwedCZraxPDJRZIPz/7CrpnxLvu2ia5LWMe9An9SakfugA/yCRT2b7gdv/cftWOTMNYtk2Zu
 njH7yLyBRRy2Nm3lmveqCj92rOncSXTfrBKE6Cfq69Qomaf1nABLBYxC3Clrqzs4qK5c5cFQ
 6AOwQIkqrIz7wqsVcXnWAOjo2+suQQVUN5dVeY97WmlzqvS/hbcBWUeSDNFQMIpudVwRjEw0
 FKN2dTzClRHsrKPTmmG3qyJtj70Mi8QRUceaisUZQ8E5cT/uoY1jwKJQtsLOKu0iNLyMSv9z
 zCDsG41gLB7pcQT/6y//F3B03Sgq/DhQgcr60PXV2S+4wVRYI+jepzu6F7H4PIGJ4GcJnGR7
 CYsmMWE6u0KS5aXm0SlQP0ENKO4+/GfdjbbhDZHBII9/j6g/3qie4F44zxkIkptdMEedlfBZ
 0veuhhY4pNJC2e7dq98Y4+3CMMCwLDpEJLuUfW8Rt9Ob4l3eSeO+Sh8YkjW022FuEomnLw7O
 JybWd2xFntcAqNipBK9QOMc1/koxyYx7WLVWZ3/iR+g1NK2dHOTDLsILlaKRuQ497+f5hXY9
 c5FMMmHwAkZV/fxChQ76qYWJFEOaH0kX5b/rpUNcvbZelY9XmY8F/XW3LUtPZR/mLhYnfvJ+
 Xf7XVJEzF34hjvMLgDihm1fVY4DlK1X9RoTVRHA937xs5T/Se5DNJsiSqY=
IronPort-HdrOrdr: A9a23:pPJtgK0sPQ9zzYfzRdv3xgqjBEgkLtp133Aq2lEZdPU0SKGlfg
 6V/MjztCWE7Ar5PUtLpTnuAsa9qB/nm6KdgrNhWItKPjOW21dARbsKheffKlXbcBEWndQtt5
 uIHZIeNDXxZ2IK8PoT4mODYqodKA/sytHWuQ/cpU0dMz2Dc8tbnmBE4p7wKDwMeOFBb6BJcq
 a01458iBeLX28YVci/DmltZZm4mzWa/KiWGCLvHnQcmXGzsQ8=
X-IronPort-AV: E=Sophos;i="5.93,195,1654574400"; 
   d="scan'208";a="79322944"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 11:42:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYyIyqkT3nc3AzJ35YZxKyTRoFGLnmuXK0ak/jMD99iCz4saej1LIme00TjRtS+m56Tb4mItRTsL8yX1TQzufHJ/+EzrwCwALAweaTg2GgfN/tTm7M4ZfCwCpRhy8b+Kf2UlMRwGAhE5ADEdOmRqnJ1LJyWKqRdogpGKcE42asZXtWFw9ZiBzJlmN2GA7TPITzlnXvMN7PlqmXhy6dg+czlG5NfEYdx3sdXAXd93M2v9FERzeL+4GUmHihcut+R6xfvevqt9NmuCymOBv3xWq1Ta2UEHJvEYO7445CuGgXFR7RMqiDMLpp6muW+e8e7gEIkRAPB9ClyaBRKJ12KPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPfBYACwUw/V8DzgjfYnPeUUskCCCURJ9k4kfqMQBFI=;
 b=dxBasgvD7PlUaCfKLWC+Sth3xIMMZfRiesALxYItE3DC7s4/XdmZx3gusWTJsckDlgerv6dEE0vtwI6gMMYbd7X4ufrIK3NDQFBSdHsWAuPD3PVTf+LvQV296YqEprkaqc3/GYIJEu0A/iO6KeZzmcF/vFJY1arBiSyHT7TH9HeH+dxlj41FiNHC0OB3uMubI96D+Ecb3LjI6pKbUgGxbNaD0aT5vP33a8rX0S6MRuJuw8ZZ7WiwDz39Gveirygom4TM8itTv08TYkm0ARfUl56My0g6j8laHYpP28ITFEUNEX+nV/64X71q2n9yCs0BJ/ZVa4l8poTNx00SaqtlJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPfBYACwUw/V8DzgjfYnPeUUskCCCURJ9k4kfqMQBFI=;
 b=UQUtpQ796WjFVVwdfFj9d031wgA9UBi7lpcpKaV6z8Ay+ovQXLUmdLicxQyYHhYyTubATidrO+2XuWLLxm4iB3agEH1fLm2VHVhDvc6VVHJedTQ+Xkm2bInoIBakujXO2N5lvB4Y0JSNzloQDlDp/r7VpIFv2CzgULrZzxINsBI=
Received: from DM5PR03MB3386.namprd03.prod.outlook.com (2603:10b6:4:46::36) by
 SJ0PR03MB6951.namprd03.prod.outlook.com (2603:10b6:a03:419::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Wed, 27 Jul
 2022 15:42:46 +0000
Received: from DM5PR03MB3386.namprd03.prod.outlook.com
 ([fe80::81f3:95a3:4853:a11f]) by DM5PR03MB3386.namprd03.prod.outlook.com
 ([fe80::81f3:95a3:4853:a11f%7]) with mapi id 15.20.5458.026; Wed, 27 Jul 2022
 15:42:46 +0000
From:   Jane Malalane <Jane.Malalane@citrix.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Jan Beulich <jbeulich@suse.com>,
        Colin Ian King <colin.king@intel.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Thread-Topic: [PATCH v2] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Thread-Index: AQHYoO9LZ/coQoD4ekyAV2OZDcw3862RTc+AgAEPVgA=
Date:   Wed, 27 Jul 2022 15:42:46 +0000
Message-ID: <31a17555-5890-9c8f-bd3a-371815453a6c@citrix.com>
References: <20220726125657.12151-1-jane.malalane@citrix.com>
 <f396712e-f567-f4f9-7b2b-a67b528e1939@oracle.com>
In-Reply-To: <f396712e-f567-f4f9-7b2b-a67b528e1939@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0232b356-1cbd-495f-5273-08da6fe6a759
x-ms-traffictypediagnostic: SJ0PR03MB6951:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zMR1ZYNO6OessrLF37DoDcRp3+i7BYown6MZQSkFJTYtWgA8sMiYRtCdRo3lRuxzZRz9a5SFoODKObSI3GGV1zhIWCgnU0wZp0XZPQLjtnjQDTZbKZJg2MUsHrXeUqw7+xN5lP4GVD6Ey8qr8XnKrtDTmBMlkHwf66qctSQQlxOqu8tFgGrK3i9VcDFDRSeBdQUvKp8RSAubulRT+f3zV8w1rFqg+t93ZwQmDZd6EA7hvMoepiY0HAGTEO6PiiCvtnWwcYse/nQMzMVsgTsIv9eHh4az3FY7H69acMeSAsMXO8WomURAkxzbjCkufBdaHe+It2jq63lzzoq4/qOLMttI4yYpJ48bJB0BClQ6b9UyLsNeJzIjRnXOh3ie8pw4mxnTgak79j+6s6B8xa6kqMWqFiB6EGbFk44fS0LMyLJRtlt32IXhAezRMk/xiaXdY48+t/KCIa7c6nhY3fGdf7xPM9JEQyBkUnUc4m7VBU6q5X6dEjYX/V3K5TQUWsMsEYuF2YjiVzonLrGaqUf85R6o82vjjOSSiSMRqHqDG4g2ws+TCIDipu70eaQ7yCOHS+8IbJS/UWnkkhTwZJw9D4l01BtLx6nGQPzIZ5CFD5Z7/ZqgUr8Dd+LXiwiksbs1UOAvaSCzeCqkgutOeHTvf9DSvydN2AgWeZ76QJuT7Fsz5GtnHoZeBaxnpk9m+EBgmALT4TB+i95Hh6+Kb2Nb2aSkT2zlojVjEbdGSzjYQaqEXRUh/me3ybwUQudsbbJ2aRlmCnFe5KwxQqKUX3CejaVrMikcJvXWepnAE5u8wV2kNdG87wX9Mc8jsUL7nvGAxkjxjkrXB1EyCPbGWbVqbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR03MB3386.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(38070700005)(8936002)(478600001)(6486002)(76116006)(6506007)(7416002)(53546011)(82960400001)(31696002)(122000001)(55236004)(2616005)(5660300002)(86362001)(36756003)(26005)(6512007)(41300700001)(38100700002)(316002)(31686004)(83380400001)(8676002)(64756008)(2906002)(66446008)(66476007)(4326008)(54906003)(71200400001)(91956017)(66946007)(110136005)(66556008)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkZzQmV6R01kaDRQQ3RzN0RoU28zeTZ5VzVZdmJ5T1A0Ui9HK1VuS1RpRU5Z?=
 =?utf-8?B?cHB2S0I4amRNMU54YUt5dWQ5SGswZGFxYUVZdWNUQTFLRVVabUM4bjREL1pv?=
 =?utf-8?B?N2ZDMDV6eEZJVzEydW80TjU2RENZYlBZdDl5bGdmZzNOQ2lCcWtteUxuWk9Q?=
 =?utf-8?B?NmY0b2VjMkYzMmZYeWJ4Y0VPenltb1Y2ajdQN0xNQ3VqSWJCVkN0VkJTR1ZV?=
 =?utf-8?B?RlJUL0w5M2hodWlFWVRnSEp1Z1VRQnJ3Q2toY1h1TXV6ODhtOHREeWt5cFdW?=
 =?utf-8?B?RFdIYkEyM2ZEUzVRSzM1dnRSSm40MitRaWdJQ1VrVlhjd1F5Smx6K01WcXJJ?=
 =?utf-8?B?SkxQTWd1S2tDVThSWWpZRmZqd3I1aGRkRjc1em9tMUttdXRmQlBDV0RaV0Jk?=
 =?utf-8?B?OVR4akdueUNKOWxwRFBjaHZmUXVCZjU1MFJ3QmF3UU1UYkxObmdnbU81UUpJ?=
 =?utf-8?B?OEFZUTllcHh3ZDdUd0w4dkVPVkNQN2NWZkIwS2Q0Q2FNMktxZTRYaXdtaFpF?=
 =?utf-8?B?QW5Vd1NIU2IwbmliV2lDSUtEZzRzcTVRQ0VvbmF3bTFQaXhGNHIrYk03Lys4?=
 =?utf-8?B?QVlJcFdBNkNSSHZzb0RqZStGR2IvNEl0c3M4aU5IUkh4ZU1BUUY2cHNJYXZG?=
 =?utf-8?B?QWVuS0xWTERjK3U3dWVCdFY3WFRIZHFMNk11REJjeHZkdmdFWGhycStCMEtS?=
 =?utf-8?B?VW5TelFhbitmbndScVhFRkt1a3lHQ3Frb1ZrNGxqY1RObXZPMjdNNVp5K0RG?=
 =?utf-8?B?ZFBUVWdUWC9rYjgyelFSeFFSOW5RbUdjMHJ4RmlKMzYwTEwyYkpIWHRBZGdm?=
 =?utf-8?B?VE5LVEFVRTE2ZTZ0Sk5vUzREWXR0c3NUYXlMSUR0UkdTelVKMFp4clpGck5N?=
 =?utf-8?B?clREK0RIbC8yMzNxUDlvUlArbmx5NXVoR0pxaXBWNmViR3A0aG1EN2dUeXVN?=
 =?utf-8?B?WFQwa1dtNXA5ZXVXb1pXM3I0YUtKNU5MTklZdVNUN0gxYk5yM3BwYUFHbWFj?=
 =?utf-8?B?REhKOFZZeE9uS3RwNEd3NldITGZYYXhGWjJ1V3U3aVc5TU1oSXM4bFpNcTBB?=
 =?utf-8?B?dC9vZGZoSEI2NjlldWxlNW5CQTV2L3FkMVlTa09jVnlvMHBWUDBieXhhRzJT?=
 =?utf-8?B?ZGRtWFhWam1EajlLTnEwc1k0bWZtOGxxZXM3aUlRZ1M1ZkgwQjFtL0puRGFa?=
 =?utf-8?B?cTYzRWZPZ2FKSklQczlDenJXQ25idk55Q0lLZVlHYmJzaUoySjI4RWV0N2Uz?=
 =?utf-8?B?WGRXK3IzWGxTYStnc1RGaVFuMlc5eThPSENia25TWTdwM0dvaFVxMFNsZjJH?=
 =?utf-8?B?VkpSQnU4cGZTaGErcE4yQmpEdjgrN2l4azNNRU1Iai8wRnhJSzVoK0NmWHdm?=
 =?utf-8?B?aU5mYUIzN1pUenk4TlZnbUtIelloL3hwbEo3ckNzNEtqTEV1a2RUWS9RaGtZ?=
 =?utf-8?B?aHFEYW8wZjJ3amdyS2FlcFJITXBzYlFsWnZReWF2UWVYTVJnTXd5TVFGMDJo?=
 =?utf-8?B?cS8zVzNPbW5jTlZXdFhPejU4Q3NxR3Zyc3FwNkQ3VXlydlc5aXdaYmxYZUFF?=
 =?utf-8?B?bEticzhKdVdQdUFmSGtLR1RXWFNOclZSbmVuSmN6Uk40ek1TRmlYbTZXL2RY?=
 =?utf-8?B?RTd5UzZwMXB3VE5vN1phVG5IK01vZ2RzSW9MT21tN0w5QnV6bjN6Njc2SUdm?=
 =?utf-8?B?L2ZEVmJjbzZRTnVMMFBqSXFMMEF5aFA0VnI2TXQzaGk4ODVuRTlZekpWVmxG?=
 =?utf-8?B?OTUyM3U1cG8yclo1WlN1WklYdXNQNjRXeTBzQ3FtYTFMS2c4WXpQZUJhczJ5?=
 =?utf-8?B?b2hsalRZSlMwYzBkT1loSXJibXp0Q2swOUF2TXlQVGhTOExxMVhkdWZqS3E3?=
 =?utf-8?B?ZUN1T0RCbzZzT2crcWRURUVsNW5pTk9TbUpFVTZPWUpibG5reTFTb3gvZEVN?=
 =?utf-8?B?S2srOFNMNUg4Z2ZWRno3clNPejlZWEZWM3FuN0xFeWFnanliNVBNcGVWQzdv?=
 =?utf-8?B?eFE3UDBSeGRSRFhWUDlTZ2pTL2VJWHJqK0ltN25HOU8ybEFoR1FaM3RST1Fx?=
 =?utf-8?B?eWNmcXVacEc4Wk9HYkRYaWZVZFNDOU10ZXIyNHRHZDBXOGl0dnBYK21ORkcv?=
 =?utf-8?B?eW1OL1lXK2M4dklKYnlDMmVPRVNBOWtobVE3dGRmTW9acXEvRWxuVUdPcitp?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <827104CC019BAA48BF1E0C5F8EF4DBA7@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR03MB3386.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0232b356-1cbd-495f-5273-08da6fe6a759
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 15:42:46.7000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0yVEPX4byjyShqv5ZGB++6DB9Nm9N9bVPNHWtR7RsffwXrkA1/jwH4I0bXzBo3mU0H9qJlm/AqMPQOOdGymB0YpCoV1rJHOzhqq4kCSlYsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6951
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDcvMjAyMiAwMDozMSwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPiBbQ0FVVElPTiAt
IEVYVEVSTkFMIEVNQUlMXSBETyBOT1QgcmVwbHksIGNsaWNrIGxpbmtzLCBvciBvcGVuIA0KPiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBhbmQga25vdyB0
aGUgY29udGVudCBpcyANCj4gc2FmZS4NCj4gDQo+IE9uIDcvMjYvMjIgODo1NiBBTSwgSmFuZSBN
YWxhbGFuZSB3cm90ZToNCj4+ICsvKiBTZXR1cCBwZXItdkNQVSB2ZWN0b3ItdHlwZSBjYWxsYmFj
a3MgYW5kIHRyaWNrIHRvb2xzdGFjayB0byB0aGluaw0KPj4gKyAqIHdlIGFyZSBlbmxpZ2h0ZW5l
ZC4gSWYgdGhpcyBzZXR1cCBpcyB1bmF2YWlsYWJsZSwgZmFsbGJhY2sgdG8gdGhlDQo+PiArICog
Z2xvYmFsIHZlY3Rvci10eXBlIGNhbGxiYWNrLiAqLw0KPiANCj4gDQo+IENvbW1lbnQgc3R5bGUu
DQo+IA0KPiANCj4+ICtzdGF0aWMgX19pbml0IHZvaWQgeGVuX2luaXRfc2V0dXBfdXBjYWxsX3Zl
Y3Rvcih2b2lkKQ0KPj4gK3sNCj4+ICvCoMKgwqAgdW5zaWduZWQgaW50IGNwdSA9IDA7DQo+IA0K
PiANCj4gVW5uZWNlc3NhcnkgdmFyaWFibGUuDQo+IA0KPiANCj4+ICsNCj4+ICvCoMKgwqAgaWYg
KCF4ZW5faGF2ZV92ZWN0b3JfY2FsbGJhY2spDQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0K
Pj4gKw0KPj4gK8KgwqDCoCBpZiAoKGNwdWlkX2VheCh4ZW5fY3B1aWRfYmFzZSgpICsgNCkgJiAN
Cj4+IFhFTl9IVk1fQ1BVSURfVVBDQUxMX1ZFQ1RPUikgJiYNCj4+ICvCoMKgwqDCoMKgwqDCoCAh
eGVuX3NldF91cGNhbGxfdmVjdG9yKGNwdSkgJiYgIXhlbl9zZXRfY2FsbGJhY2tfdmlhKDEpKQ0K
Pj4gK8KgwqDCoMKgwqDCoMKgIHhlbl9wZXJjcHVfdXBjYWxsID0gdHJ1ZTsNCj4+ICvCoMKgwqAg
ZWxzZSBpZiAoeGVuX2ZlYXR1cmUoWEVORkVBVF9odm1fY2FsbGJhY2tfdmVjdG9yKSkNCj4+ICvC
oMKgwqDCoMKgwqDCoCB4ZW5fc2V0dXBfY2FsbGJhY2tfdmVjdG9yKCk7DQo+PiArwqDCoMKgIGVs
c2UNCj4+ICvCoMKgwqDCoMKgwqDCoCB4ZW5faGF2ZV92ZWN0b3JfY2FsbGJhY2sgPSBmYWxzZTsN
Cj4+ICt9DQo+PiArDQo+PiAraW50IHhlbl9zZXRfdXBjYWxsX3ZlY3Rvcih1bnNpZ25lZCBpbnQg
Y3B1KQ0KPj4gK3sNCj4+ICvCoMKgwqAgaW50IHJjOw0KPj4gK8KgwqDCoCB4ZW5faHZtX2V2dGNo
bl91cGNhbGxfdmVjdG9yX3Qgb3AgPSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgLnZlY3RvciA9IEhZ
UEVSVklTT1JfQ0FMTEJBQ0tfVkVDVE9SLA0KPj4gK8KgwqDCoMKgwqDCoMKgIC52Y3B1ID0gcGVy
X2NwdSh4ZW5fdmNwdV9pZCwgY3B1KSwNCj4+ICvCoMKgwqAgfTsNCj4+ICsNCj4+ICvCoMKgwqAg
cmMgPSBIWVBFUlZJU09SX2h2bV9vcChIVk1PUF9zZXRfZXZ0Y2huX3VwY2FsbF92ZWN0b3IsICZv
cCk7DQo+PiArwqDCoMKgIGlmIChyYykNCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmM7DQo+
PiArDQo+PiArwqDCoMKgIGlmICghY3B1KQ0KPiANCj4gDQo+IEEgY29tbWVudCAoZS5nLiAiTGV0
IHRvb2xzdGFjayBrbm93IHRoYXQgd2UgYXJlIGVubGlnaHRlbmVkLiIgb3IgDQo+IHNvbWV0aGlu
ZyBhbG9uZyB0aGVzZSBsaW5lcykgd291bGQgYmUgdXNlZnVsIGhlcmUuDQo+VGhhbmtzLCB3aWxs
IGluY2x1ZGUgYWxsIHRoZXNlIGNoYW5nZXMgaW4gYSB2My4NCg0KSmFuZS4=
