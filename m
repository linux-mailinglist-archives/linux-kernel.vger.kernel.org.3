Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A450357A425
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiGSQXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiGSQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:23:40 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218C152FF4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1658247819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PELPJwh/Z1EKK2lSpvjYni/Ym+XGNpoOsK8Zwf1+QCs=;
  b=Z8n+SRtKjbMdhsMnHl2FLTMmVH5CXaGfaXPWG9yNETvpK6jK+s6FJh7t
   kclv53Op/RAkxFsJp5mno0jWyldsa+T1DaVUuPywJd39yFJ9+/Rk1xmgy
   QtevIvb8ze/CQVQbtzBlwBftZ/3QaXv3SS7GYlpl/zKCsrdjR+Yb8B72t
   0=;
X-IronPort-RemoteIP: 104.47.59.174
X-IronPort-MID: 78720116
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:1GIv6KwnA6mMjGWFC2N6t+ckwSrEfRIJ4+MujC+fZmUNrF6WrkUBm
 GYXC2qCOf+NMTP9fNt3YI+xox8G6pfdzNVhQApv/CAxQypGp/SeCIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bv676yEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii8tjjMPR7zml4
 LsemOWCfg7/s9JIGjhMsfjb90o+5K6aVA4w5TTSW9ga5DcyqFFNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1jqEl/uFIorNfofTKiXmcJaLVeS9oiM+t5yZqgpDvkQPPpMTb5LwX6v1ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1UDEE/Y7AY+Nx9GGpQ3
 r8/JTo2UDKM0rfeLLKTEoGAh+wFBeyyZsYzny8lyjvUS/E7XZrEXqPGo8dC2ys9jdxPGvCYY
 NcFbT1ob1LLZBgn1lU/Ucpi2rv3wCSuNWQH9Dp5poJui4TX5CV33KLgL5z+fduSSN8Otk2Zu
 njH7yLyBRRy2Nm3lmraqCr137GncSXTfLMLK42Y9vJWi3aUwmkiLD0KemOYvqzs4qK5c5cFQ
 6AOwQIyoqwi3EiqSMThRRq+oW7CshN0c95RFfAqrQKA0KzZ5y6HCWUeCD1MctorsIkxXzNC/
 k/ZwfvqCCZpvbnTTmiSnp+IqimsMCwZNkcGZCkZXU4L5MTlrIgvjxXJCNF5H8adktzwXzq2y
 DCHqgA6hrMOnYgK0bm2+RbMhDfEjprRSQ8w7ALadmGo9AV0YMiifYPAwUDS8v9GaoWES1Cb+
 ncZg9SXxOQPC4yd0i2LXOgJWrqu4p6tMyLdglhiBbEs6zS/vXWjFahZ5CBlP04vN8cAcyLzZ
 mfXuAVM9NlSOmenael8ZIfZI8Yjy67gPdviUf/QY5xFZZ0ZXA+F+GdyYkmUxEjilUEtlec0P
 pLzWcSrBHFcDKN9wTusTs8c16MmwmY1wma7bZL81Bm/0fyYeWyQQLEtMV2SY+R/56SByC3P9
 M1DOseW4xpYV+H7YzKR9pQcRXgIImI8HovesNFMe6iIJQ8OMHksF/LL05sgfYJ/lqhYn+uO+
 WuyMmddyFvljHjONS2JZ2plZbepWoxwxVoyJjAEPluy3XUnJ4G14883e5IxfLQj3O1kwvN9V
 fMCa4OGD+gnYjfW4BwYbJLnq5dlegjtjgWLVwKlaTkudphvVSTM+9T+eRDo+jVIBS2y3eMlv
 72t0wbaR7IGRg94C93RZu7pxFS01VACleM0W0rVCtpeYkPh9M5tMSOZpvM6KNwNARDCzSGdz
 AGYHVETouyli4o089TNga2Vh4KoGPF5BU1UAy/Q6rPeCMXB1m+qwIsFXOPWeznYDTnw4P/7O
 rkTyOzgOvoamloMq5B7D7tg0aM54Z3ouqNeyQNnWn7MajxHF49dH5VP5uEX3oUl+1OTkVLet
 p6nkjWCBYi0BQ==
IronPort-HdrOrdr: A9a23:3VPqnajmoLck1WpRNoiSc/Gf83BQX3l13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IwerwQ5VpQRvnhP1ICRF4B8buYOCUghrTEGgE1/qv/9SAIVy1ygc578
 tdmsdFebrN5DRB7PoSpTPIa+rIo+P3v5xA592uqUuFJDsCA84P0+46MHfjLqQcfnglOXNNLu
 v52iMxnUvERZ14VKSGL0hAe9KGi8zAlZrgbxJDLQUg8hOygTSh76O/OwSE3z8FOgk/gIsKwC
 zgqUjU96+ju/a0xlv3zGnI9albn9Pn159qGNGMsM4IMT/h4zzYJLiJGofy/wzdktvfrWrCo+
 O85yvI+P4DrE85S1vF4ycFHTOQlgrGpUWSkGNwykGT3PARDAhKd/apw7gpPCcxonBQwu2Vms
 hwrh2knosSAhXakCvn4d/UExlsi0qvuHIn1fUelnpFTOIlGfZsRKEkjTRo+a07bVTHwZFiFP
 MrANDX5f5Qf1/fZ3fFvnN3yNjpWngoBB+JTkULp8TQilFt7TtE5lpdwNZakmYL9Zo7RZUB7+
 PYMr5wnLULSsMNd6pyCOoIXMPyAG3QRhDHNn6UPD3cZek6EmOIr4Sy7KQ+5emsdpBNxJwumI
 7ZWFcdrmI2c1KGM7z74HSKyGG5fIyQZ0Wc9igF3ekJhlTVfsuZDQSTDFYzjsCnv/ITRsXGRv
 fbAuMlP8Pe
X-IronPort-AV: E=Sophos;i="5.92,284,1650945600"; 
   d="scan'208";a="78720116"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 12:23:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcqsyYBTWOu2iArzBC05HckQn62skpwjrI1hyNBoek4StCUV+pV3o+uKQwEE9XGnLFbm+7ZW5AU1tbJuUlHDotCGZiwRq5udn3IqAd34GE5t18iMEh/Np1Olc7nB1TRfQI1zGIarh0eSh8Nnut9r0k5z/kGzX+qkF17QUAj+2MSCg+RtHcVXc2PXOwXT61WrYmFWytkLpl02n7/S4PF12Pjv/9ZANhN0wJkwKJbMW+mzxPVDl0qKE+uKG/IvOzTxAjOXzT9ErvGDkTgwQ3B6x+9mDn/mRa0vnHNxQUMDHEJHLVqYvqu1FTOnF2hmTNooEGuWvTlMql7fJjkylB1STA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PELPJwh/Z1EKK2lSpvjYni/Ym+XGNpoOsK8Zwf1+QCs=;
 b=kqD0AwHS9kgLwfBtR21HeIArlWrwwLYUBUspTkJD3XZ0orZD0HzvXITHvdkTlS6CKzln90+vF8w5WEXW08wHiukiqAHZ7KRQENOFFZdOmifuDQ+dGg94400zg2Ygcd1hwmEbfm5n90uIXaPD+h9b6oznhLBiHky6hKSF4tyNDhtttlU8h6jnN4bbPHP3vJHCYMHEYj04liOwWWP+EA5sQOnY0WbmkqnYWjYXq1bR/qU9ofzGul0p8t55dObbUprL6xjRWk25ioG+0xg7lWuxj1O23l8l6JuVaHeIfgz7YlsAz2Vz+lNPkLKqcghILjVkQxfmNhB7H8e1wIjhg7pLaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PELPJwh/Z1EKK2lSpvjYni/Ym+XGNpoOsK8Zwf1+QCs=;
 b=JWAUQKW001wPoU5dF+VHiV4mSB7Yy1wCZu4rP0BeQBmV/Y7Lv2y/XoBO6En7c+sjv1cD4LOCxVjHOAAfr2VWNhzx7/PVspW1xPLIDWKCBNeAztV4ZQThdIjp9izVSIToLww19xDW1SrauET4TqEZaYEEtsR0KlC6dpBEElNYGFE=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BY5PR03MB4981.namprd03.prod.outlook.com (2603:10b6:a03:1f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 16:23:31 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c%4]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 16:23:30 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: Virt Call depth tracking mitigation
Thread-Topic: Virt Call depth tracking mitigation
Thread-Index: AQHYm1m+Rhbzf0W840KUAhk5fXVBkK2FvK0AgAAkYoA=
Date:   Tue, 19 Jul 2022 16:23:30 +0000
Message-ID: <261e141a-7e7f-ce26-60fe-df1957e393df@citrix.com>
References: <20220716230344.239749011@linutronix.de>
 <4ca4a4ab-6ea0-d94a-59cc-1ab99ff869d5@citrix.com> <87a695ur5v.ffs@tglx>
In-Reply-To: <87a695ur5v.ffs@tglx>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecb6a18d-6ed6-4487-56e3-08da69a304ab
x-ms-traffictypediagnostic: BY5PR03MB4981:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f89fhTvuHYRz4BCl0/P3C9fukrLK10lnDmsH/NL61crfIEU0MLOuAlj0NKJk/nLIRJXEhxZbOt64wZI2iUzMp7Xx48IUsmuTfj0x8Db5e6Px8R1ZrRQ9ZVQh1NJr1H4Bp4kOEAdyK2+amWEC4OIi2ejPI5pn7A8oi6tIhacZQZPXK846eAnQ8HWd7lrBNBd7r408RIqTr2ksUC5HFCA8UNJnmDdwsc3t9H+aUguvKm254fDgdwE96H4+I5AlPXijb7gCytiOdox+LP6mOEOTWy4ZjpRAPJSExZUyMiXvU58NizWrLyG95PXtKdyKs0CsdxXUGsCRWulGxxM5LUzgb7bI3BgutQrWaBoKxqrqhIRWZFrJQ7Ys6iHY0hzNv2TAbps3jSsJYjd8Fly3udyZBhyltVQWKGl3HU9OdcsnzeKYkop+eAD25G3QLWg16PjJtR6aPaNbuCh02oKucIjrMgT24J+aMLHsukoQ8i2neI7PKPEH1xRC1nvZY9iJMS0WbM6kxukqB8WQLj0dlO2Hy0nhwMbAwlWAEY9XKwjwYRQXp8hc3YyVYbVsH1jbVNnxcsBrfWdIkjyjy9S32CVKrG4r3orr+hChWQ79Gwir+tivcwLz954nbn+pkaW82XIsKdVzUKQiILse9kKFPEyaOz9riDyPHtQ3BGc7OCFgnkQ/wxGwztxzcvE02BMFBSEkNZs+j++xhUWq4ptQ6EsB9XIchW5HKlwXvwKb0zvt/LvU/GpKVWlot2wTevWtP/flbzOTYls+lg1gj5ZxdnNWUWxZYoMbtYxyxIv7XnvcAIBXbbtpA89oXe6vzaU6HS7UniE+V5Ll5utsznQ3MuGkISitSPj3zDjUKbSPTJ7zsDem17u4Fn/6iqiWJZrduW5T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(31686004)(4326008)(122000001)(8676002)(76116006)(38100700002)(82960400001)(83380400001)(186003)(5660300002)(66946007)(8936002)(64756008)(2616005)(36756003)(66556008)(66476007)(2906002)(91956017)(66446008)(7416002)(110136005)(54906003)(478600001)(31696002)(26005)(53546011)(6512007)(41300700001)(86362001)(6506007)(316002)(38070700005)(6486002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3Vva2FRRG9tUml6Y1pSNWU4SDMwVUxSeHY0ejVIa2FQQm1mU3R3QW44aGlW?=
 =?utf-8?B?WFpzenpHemNkSzJyVG9Ic1JxY1VISlpldUtCSnFLbFl1U2hhUlh3ajVCTlY2?=
 =?utf-8?B?UzJUWGRVeFBrWEJjSHdqUVd6L1ZjU0J0VUoxcFVML0YybVhINE9WSW9jKy9x?=
 =?utf-8?B?Y3gzQmwvRlI4SXAwZUVLOHc1Y21mRGMvOWg2cXVoSEUzQXFRblBuZTdVRzdp?=
 =?utf-8?B?M1VIdkMyTUZCYUdNTXVNL3d0MEU4V2hhbEZnUnE4MHRsWlpRc1daQ2FndkpB?=
 =?utf-8?B?VnlobzhxUzk5YnBQZFY3YmcvT1IzaUFjZzJES1RuUGh4L0VQZlVSZWxCeTFp?=
 =?utf-8?B?QVBxTEd0Nk12WVZWS0VudEF4Tk1EVWVvMjNQOWU5SjNoRlhRdWNnQjI3cTIv?=
 =?utf-8?B?OEdsNTh2ZEN6ejNZRysrOFZOVUwxYnpscUEvdzArLzdJSm5QVzkrRGgzRndL?=
 =?utf-8?B?WVgvRjFYSU1wZ0pzQnh2eXRvME9JMElSWmM3eG1vbUs4MXVCNmhadmpoTXRC?=
 =?utf-8?B?blFjRE1Qa3pzMXh1NFMvWTZCcTlqRThLaWhxT2pFSTgxR2RtZEs1V2V3RTZO?=
 =?utf-8?B?VitOL2g4TE0rNnBoVW00YkUyOEMyNGZwTElma2pPbGZhTVFTTFI4Z0lKODVn?=
 =?utf-8?B?bWhoaTJUclZGZFNpU2cvTHV2S3c0Q29vRXBWb3NDNW80QnlSKzI2TjZhRHdQ?=
 =?utf-8?B?SHJNam1LSklxTmVZcVhUWVBOWm9YTmszMlh5Mm5hQWNnQ2NleEcvZnJ1MGtM?=
 =?utf-8?B?ZkR5Wk53TEl0MkppS2NOVFoxVlNYTXBhcUNiZFZGbjJDSDA5eERNMzNIOTZU?=
 =?utf-8?B?STdMeDBMb2kzWHN6akxtdnk4K21yQzJqNUg5aDd5R2ZwWnpJYWExWGZXN0JS?=
 =?utf-8?B?UHFjU29ycEg4MG41d2dIT1hWUEkxWmdhRXo2ZEZ0TjdMK2hrUy9mdSsvSkNH?=
 =?utf-8?B?a2NOTWh1MG1jVVN4WVFGZ0hweW5ZMFFVSUxTc3k2RkJaUmdTVlVmRmVhUzY3?=
 =?utf-8?B?c1ZWaENjcENPYXlpNGsvbEJVQmxFUkVuK0RyUGJIY2dSK1pWRWxnVlp5Rnp5?=
 =?utf-8?B?bWpuZFdiOGxqVG9vWGZjRW53UStyMktaMFBVenA1dXdQemxHVllZNy9aWU52?=
 =?utf-8?B?Q0NCNzhHNnBDNENoM3VpWjdUaUYrcHc2TUpuTVo5VDVwRjVoVzdVakVsNHZL?=
 =?utf-8?B?Z3dWWmh2bEVmSHl3WmR3TFNDZXloOTJRVTlVRTJsUDlvSXV1T1BCNHFEeEJu?=
 =?utf-8?B?SW82TlZieTMxd2xFM1ZNc21KdjdZSk5kSjQ0K1B6ckFEN0o5OFA0M0txVmpm?=
 =?utf-8?B?eXRSblN2QTN4RmxNUlJxQUw1U0NaVjRwZGowcTZVVjJMNzZhdnpMLzNJemF0?=
 =?utf-8?B?OGY2SFJzSzJxSG1jMDRESUNibmZERlV5VFhQWVJIRURobmhZUUNZT3NETWM1?=
 =?utf-8?B?bkdQZFdvS3FKSC9yM2cwdGJVTWZjZlZYc3NKT1loNklpdkdrQ0xpV2IxT1Zx?=
 =?utf-8?B?aEFUR2d3a0VLcTlnMWkreGxOQkJ1cDlnb3hpOU93cW1pa3VOVkE1TW5OTkxj?=
 =?utf-8?B?M3RqZUVzekFFdEVTd05SeDRnS1VYa3pwS2Y4ckVkZE8ycmFCU3lvNlJVM2F3?=
 =?utf-8?B?UXRPaERiZnBremRjdWdQcE1IUG85S2ptempnWnhweEdXQnVWOGFIV2xiU1hs?=
 =?utf-8?B?RnRXUG9XWFZxZ2VvLzhORk9xVlQ3WlFJTXhVU01xL3NuYVBmL2Z4Z2Z4aEVC?=
 =?utf-8?B?SzVqejRncm1JN2xsVjR4R1JkTkVlVCtXMVhIaVN4bW4yaDBwRmpmRlFvcHor?=
 =?utf-8?B?ajI4bFNuV2ZQSWhCaHVXdndqNWx6VXUwUXNuTDVrRkpMWk43clM4Ynl4WVJN?=
 =?utf-8?B?NGFkQmxoSUx5RmQzM2ZMelNKR0pDUzZrQ0w5T1Q5UWV1UUhvSmxnUFAzWm5r?=
 =?utf-8?B?ZEx1TlBpUUxHSXluKzhCMUFET0xWMmJJV3BxYnBIOEVlaTNFN1puV1NkakVj?=
 =?utf-8?B?K0tGOTdmZnpNM0w2REN3ck1jWTJEa3JYeStNVnhKYjd6czFNeFlJU0pWZkxD?=
 =?utf-8?B?ZlZ6MXQ4SFRlNTBYWlVtL2FDNzdNbXY0QVdXUDlLUFlUWGNGT2lYampWRWtR?=
 =?utf-8?Q?rQuW5D+fD2FD9cB2Wx4qyXbDR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A8F0A693F7F114BA2C40D6347011A82@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb6a18d-6ed6-4487-56e3-08da69a304ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 16:23:30.4645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utQZpmxaEsgr8KejE1nza36zKxw+Q1RqZ3QgxXQfgmlEfdTfOPA1u80ug9kP7nWkIf/Uo5UC2y5XKQEDQQAvoCYjfh4BI9deOnO4ZLy3tJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4981
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDcvMjAyMiAxNToxMywgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBPbiBUdWUsIEp1
bCAxOSAyMDIyIGF0IDEwOjI0LCBBbmRyZXcgQ29vcGVyIHdyb3RlOg0KPj4gT24gMTcvMDcvMjAy
MiAwMDoxNywgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4+IEFzIElCUlMgaXMgYSBwZXJmb3Jt
YW5jZSBob3Jyb3Igc2hvdywgUGV0ZXIgWmlqc3RyYSBhbmQgbWUgcmV2aXNpdGVkIHRoZQ0KPj4+
IGNhbGwgZGVwdGggdHJhY2tpbmcgYXBwcm9hY2ggYW5kIGltcGxlbWVudGVkIGl0IGluIGEgd2F5
IHdoaWNoIGlzIGhvcGVmdWxseQ0KPj4+IG1vcmUgcGFsYXRhYmxlIGFuZCBhdm9pZHMgdGhlIGRv
d25zaWRlcyBvZiB0aGUgb3JpZ2luYWwgYXR0ZW1wdC4NCj4+Pg0KPj4+IFdlIGJvdGggdW5zdXJw
cmlzaW5nbHkgaGF0ZSB0aGUgcmVzdWx0IHdpdGggYSBwYXNzaW9uLi4uDQo+PiBBbmQgSSBoYXRl
IHRvIGFkZCBtb3JlIHByb2JsZW1zLCBidXQgaGVyZSB3ZSBnby4NCj4+DQo+PiBVbmRlciB2aXJ0
LCBpdCdzIG5vdCBqdXN0IFNNSSdzIHdoaWNoIG1pZ2h0IHJ1biBiZWhpbmQgeW91ciBiYWNrLsKg
DQo+PiBSZWd1bGFyIGludGVycnVwdHMvZXRjIGNhbiBwcm9iYWJseSBiZSBoYW5kLXdhdmVkIGF3
YXkgaW4gdGhlIHNhbWUgd2F5DQo+PiB0aGF0IFNNSXMgYXJlLg0KPiBZb3UgbWVhbiBob3N0IHNp
ZGUgaW50ZXJydXB0cywgcmlnaHQ/DQoNClllcy4NCg0KPg0KPj4gSHlwZXJjYWxscyBob3dldmVy
IGFyZSBhIGRpZmZlcmVudCBtYXR0ZXIuDQo+Pg0KPj4gWGVuIGFuZCBIeXBlclYgYm90aCBoYXZl
IGh5cGVyY2FsbCBwYWdlcywgd2hlcmUgdGhlIGh5cGVydmlzb3IgcHJvdmlkZXMNCj4+IHNvbWUg
ZXhlY3V0YWJsZSBjb2RlIGZvciB0aGUgZ3Vlc3Qga2VybmVsIHRvIHVzZS4NCj4+DQo+PiBVbmRl
ciB0aGUgY3VycmVudCBzY2hlbWUsIHRoZSBjYWxscyBpbnRvIHRoZSBoeXBlcmNhbGwgcGFnZXMg
Z2V0DQo+PiBhY2NvdW50ZWQsIGFzIG9ianRvb2wgY2FuIHNlZSB0aGVtLCBidXQgdGhlIHJldCdz
IGRvbid0LsKgIFRoaXMgaW1iYWxhbmNlDQo+PiBpcyBleGFzcGVyYXRlZCBiZWNhdXNlIHNvbWUg
aHlwZXJjYWxscyBhcmUgY2FsbGVkIGluIGxvb3BzLg0KPiBCYWguDQo+DQo+PiBXb3JzZSBob3dl
dmVyLCBpdCBvcGVucyBhIGhvbGUgd2hlcmUgYnJhbmNoIGhpc3RvcnkgaXMgY2FsY3VsYWJsZSBh
bmQNCj4+IHRoZSByZXQgY2FuIHJlbGlhYmx5IHVuZGVyZmxvdy7CoCBUaGlzIG9jY3VycyB3aGVu
IHRoZXJlJ3MgYSBtaW5pbWFsIGNhbGwNCj4+IGRlcHRoIGluIExpbnV4IHRvIGdldCB0byB0aGUg
aHlwZXJjYWxsLCBhbmQgdGhlbiBhIGNhbGwgZGVwdGggb2YgPjE2IGluDQo+PiB0aGUgaHlwZXJ2
aXNvci4NCj4+DQo+PiBUaGUgb25seSB2YXJpYWJsZSBpbiB0aGVzZSBjYXNlcyBpcyBob3cgbXVj
aCB1c2VyIGNvbnRyb2wgdGhlcmUgaXMgb2YNCj4+IHRoZSByZWdpc3RlcnMsIGFuZCBJIGZvciBv
bmUgYW0gbm90IGZlZWxpbmcgbHVja3kgaW4gZmFjZSBvZiB0aGUgY3VycmVudA0KPj4gcmVzZWFy
Y2guDQo+Pg0KPj4gVGhlIG9ubHkgc29sdXRpb24gSSBzZWUgaGVyZSBpcyBmb3IgTGludXggdG8g
cmV0LXRodW5rIHRoZSBoeXBlcmNhbGwNCj4+IHBhZ2UgdG9vLsKgIFVuZGVyIFhlbiwgdGhlIGh5
cGVyY2FsbCBwYWdlIGlzIG11dGFibGUgYnkgdGhlIGd1ZXN0IGFuZA0KPj4gdGhlcmUgaXMgcm9v
bSB0byB0dXJuIGV2ZXJ5IHJldCBpbnRvIGEgam1wLCBidXQgb2J2aW91c2x5IG5vbmUgb2YgdGhp
cw0KPj4gaXMgY292ZXJlZCBieSBhbnkgZm9ybWFsIEFCSSwgYW5kIHRoaXMgcHJvYmFibHkgbmVl
ZHMgbW9yZSBjYXJlZnVsDQo+PiBjb25zaWRlcmF0aW9uIHRoYW4gdGhlIHNob3J0IHRpbWUgSSd2
ZSBwdXQgdG93YXJkcyBpdC4NCj4gV2VsbCwgdGhhdCBtYWtlcyB0aGUgZ3Vlc3Qgc2lkZSAic2Fm
ZSIsIGJ1dCBpc24ndCBhIGRlZXAgaHlwZXJjYWxsID4gMTYNCj4gYWxyZWFkeSB1bmRlcmZsb3dp
bmcgaW4gdGhlIGh5cGVydmlzb3IgY29kZSBiZWZvcmUgaXQgcmV0dXJucyB0byB0aGUNCj4gZ3Vl
c3Q/DQoNClllYWgsIGJ1dCB0aGF0J3MgdGhlIGh5cGVydmlzb3IncyBwcm9ibGVtIHRvIGRlYWwg
d2l0aCwgaW4gd2hhdGV2ZXINCm1hbm5lciBpdCBzZWVzIGZpdC4NCg0KQW5kIGlmIHRoZSBoeXBl
cnZpc29yIGlzIHVzaW5nIElCZWVSUyB0aGVuIHRoZSBmaXJzdCByZXQgaW4gZ3Vlc3QNCmNvbnRl
eHQgd2lsbCB1bmRlcmZsb3cuDQoNCj4+IFRoYXQgc2FpZCwgYWZ0ZXIgYSByZXR1cm4gZnJvbSB0
aGUgaHlwZXJ2aXNvciwgTGludXggaGFzIG5vIGlkZWEgd2hhdA0KPj4gc3RhdGUgdGhlIFJTQiBp
cyBpbiwgc28gdGhlIG9ubHkgc2FmZSBjb3Vyc2Ugb2YgYWN0aW9uIGlzIHRvIHJlLXN0dWZmLg0K
PiBJbmRlZWQuDQo+DQo+IEFub3RoZXIgcHJvb2YgZm9yIG15IGNsYWltIHRoYXQgdmlydCBjcmVh
dGVzIG1vcmUgcHJvYmxlbXMgdGhhbiBpdA0KPiBzb2x2ZXMuDQoNClNvIGhvdyBkaWQgeW91IGxp
a2UgZGVidWdnaW5nIHRoZSBnc2Jhc2UgY3Jhc2ggb24gbmF0aXZlIGhhcmR3YXJlLiA6KQ0KDQp+
QW5kcmV3DQo=
