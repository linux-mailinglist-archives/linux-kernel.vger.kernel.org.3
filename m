Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BDB575D43
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiGOITi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiGOITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:19:36 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 01:19:33 PDT
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4D31C91E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1657873173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tU36mPMvGMR4pFpwKSZ/n9B/7cKnZJksI9dkuvajUUc=;
  b=WKlQzdosRN1gVDgKvwj5I1nz0+b+tm4LyTb1RG/lzNlSzQ3vQUkMzJ/n
   N2Iw94bS455Wqn0s7nGQhHfy16fsylmcPEt1Fkjgo35ZmW1xQ1O98bMTr
   5/iEEbuYKgHweKbXSb3iKRdD+BR8xMIIJ58eGK0/XkOImpXUHv+pcyh+8
   0=;
X-IronPort-RemoteIP: 104.47.73.177
X-IronPort-MID: 75860348
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: =?us-ascii?q?A9a23=3AKXQ9G6vWxPUXlXa15ug105Ad5ufnOphVZpANC?=
 =?us-ascii?q?cmfNqXej2XJXxfKv0VeTJM5Uo87buhUoIT61S7M9MUuHW69dM8B7dbbYfLqP?=
 =?us-ascii?q?tBry85aM5BzRjERZHfJoamesGtX0DSC/+Ec6WCudI4CHxXZPAY10Qots6xRf?=
 =?us-ascii?q?5+vfAAyvU+KWVNB9TeLJ+T7DrKZMpasbyMdJL4upZOnMrewOi1pn16XED4Xo?=
 =?us-ascii?q?j2uo5BpCfhYfMCScj6JFsat8lRzA280TXScH/xUn7vuKxKaZfkWe24sUDfSQ?=
 =?us-ascii?q?XHmfBkYy0Gghx/VkKi+gAJwu48Jn91te20WYoV0Gwk7d/an25FC8YleWo6Mt?=
 =?us-ascii?q?ggTDKSjiJk9DwSWeWeIhLt8blIeSZzW7lTbys4+IzXcRsTMEe/DmHQfaTWxp?=
 =?us-ascii?q?OouYX1C7XrpP4KAwIPikjmpRTp1QPbxxPCCjDJYi3dpFN9Tj34aWK/QDju7T?=
 =?us-ascii?q?TIx/xQxYaiPDCy2+TTr8qmtGUM+vXB0t6TTMBApwKURDNcg5rIpWSIdALviQ?=
 =?us-ascii?q?MH6LuA/0pOhf6LtcT4523A9VEVLF2AqmOk8Qu4q1OtgGHs8r9vbb85Xn4dq1?=
 =?us-ascii?q?m8IGgk1mD+DrmAwMQkz0z2T5MZnX4sP/hbqayX8FEgWDVu8xnx0M5Ltysk7T?=
 =?us-ascii?q?wurDAzfua6K3deFRvAOKx/v5PiMHC2Mm+UWcU30df7TM4brktAFq5ZOywVUE?=
 =?us-ascii?q?im4aqE0UAyLCO7HIpSekjddonco+Ka6zlDedgtbbsqov2wGNmieWuSY/cn6q?=
 =?us-ascii?q?yHZoyNSPVSxjz8CLG7SX4/JvqoiLdMCjZZR1Xx5SVkmr2iKS+H+/hzC2Qfia?=
 =?us-ascii?q?HhnbbX4D5lpXCmKBazzOumLYDXmxJHNiPDY8FsGXeCpfsXasQ2P1oB+tqT7E?=
 =?us-ascii?q?wRcHH2KgjI5sdDfTx1GKkuWOvu7xwyEUGzegZLlfB5NU4oc5qMNz6SmhyW4c?=
 =?us-ascii?q?mIuFOPdW4zPAopk2yYCfcve9okFxh3sdVwRg/9S5jPs11Jh3RMWUicA3I2gG?=
 =?us-ascii?q?a+OH7ceiwvedW2H1xxcwVavXrnwlhNQWp8fAi1E0cuCmAFRnMQTRTSTez4KD?=
 =?us-ascii?q?wEDfBtZpzA/nwXN0UQtZiOCFrXItW8EtIrG1xjRDkKeoi05IojFX386HC2HV?=
 =?us-ascii?q?Q6UCypp0N9UWgb/L0Dn/FUfi0EM66XICvKlyZa4ePAklhikfB2Ixo0GnmecQ?=
 =?us-ascii?q?XiheBZh6MYMQV3drTIqQiEnElZ/YuUprxWdgVeRxnrJr72yKauP2shB0oSNq?=
 =?us-ascii?q?ZOvcfsEitWSpPh+ulVBu/CW5x9DcwVkWpMLV/q6Qn1HucfoySmaS41tSNArB?=
 =?us-ascii?q?mvFSTqmQFXM5UXGv0tEv0Asy1kCwiKds+NQtDDLJPCdGaLO/w94pkmCMbA7D?=
 =?us-ascii?q?LlVnGOMaOO7KX+ecd89gh9pwvaQsGZsd5NBMnWdGaqeF3SNRBspASBTsYP4B?=
 =?us-ascii?q?4sCopEcmHc7ACkg18BErN72gHKXk1ebDkRakLDq/SiWhE5dEl6u47wH8dx8T?=
 =?us-ascii?q?S2Y42U7qU4dEOz6TCaocC5rGCXZiUuihh+zNPkImnpAxNuFMa4j6uUvzADvP?=
 =?us-ascii?q?lZk344thmh0DDgaqZrX3dRidekXlo03DregT3SJHTIpygF/Tn9DITX1eJ2SX?=
 =?us-ascii?q?CIz83hjhyygFlKG2Ee6oYNujTA6dKhErolTAZ19C9jwFIvVH4P2YNU44yXqP?=
 =?us-ascii?q?C6xflduI8SXk42L+Mqn08CcKqxHg8TZSdYvbMmBv3OBca2030q84VlPpWSjA?=
 =?us-ascii?q?xKO54s3ReqZZkeJbGQX1xx4LXrmv0uHgfi4mMKrOnkGcxykKDoK6L+5TCacs?=
 =?us-ascii?q?EXSNafiKaLRxn4dIGAuby8US4Fx/z7cP/QmXwfVFnOp9mcKgxfND+ZySIHIm?=
 =?us-ascii?q?/b4xZdgi56JJxOcaRYrZEAXGCis5ueCmrilo+oOaVNb9D93YF1w2fCZG2AmP?=
 =?us-ascii?q?/wU6KE3S/EamNO0RLm622dNeiy4gfiZHWwP4f4ug9/ZJEE6F0Y6HT8LnEMnP?=
 =?us-ascii?q?5eT/Ub93DkJnHkmzyhrnDWPI+dljJg9/3JxAyazlA6CpKv2pbCnCciiLNudH?=
 =?us-ascii?q?3SrAX2L25qiq+pqTRXiYpaX9jTwLGr4sVJnaiqkhJVjZ+SYZfsiqRzVNXk3C?=
 =?us-ascii?q?Fj/zqr5tx55xqW3UeyDt0PSM7eZdu+EL+zaS7RvQFRhypqAbcgPWhEeSo7oV?=
 =?us-ascii?q?eDimi+6I1foTbdxrZe5rsnI5IEroDKgfrEj4L+gnqVwizro+nXlTrwLYT6Rl?=
 =?us-ascii?q?3bqnulfZ0sPcDJT2dB0Bz9ns2hzDDSccqEjeR4Mxtq51OfsBfLAQoWijmIKX?=
 =?us-ascii?q?rmuRxhm7wXQfoS6SpZihQOzrc4xXZdl3GD5U0+2MPo5Rw1DzealNDVndNyEq?=
 =?us-ascii?q?6bqyKRszrhJgX42vJQVi6zq+81w/upE+vsjplUhBiUyKfxum+LYJzScnIdpv?=
 =?us-ascii?q?ivF6dpAW/lNdszmyAeCTMnSIsnsGfsNP85qtYxYtxPNADbP8sJhcObuhwY2x?=
 =?us-ascii?q?2H22LQNgws/7G178b6cpDiZLgQs9yu1a9BTXMEOrSO/362EcW+2MNh15c6h4?=
 =?us-ascii?q?u40wYEFYegt22ByVwei512JSXL6UORZZ0pPUOTn6p5ug7LFxOawt6eaEUjlp?=
 =?us-ascii?q?8XEOXdm6CVLwNNHnHyvmWr/JpYI2oFyes0plfuhlqo9BCPwJmRYkt0hb2Jyc?=
 =?us-ascii?q?Fu5O3l1atNtuKSl5hrg14bztr1S99DEJzh0i/Guz23LylPXMHmZlOwDx/Paq?=
 =?us-ascii?q?1F1MlytWriQgz9XbFIq81yDHtn6z7x0mi6BD/KQdVtBJ8T7R/6pzeoDG6Xzx?=
 =?us-ascii?q?Y5RJo/INna3sS9+iN28ltzi0kPR+TYJlJxMszHGWlw3Ndve2NfvK5P8HKOm/?=
 =?us-ascii?q?ICTRnhQqc0VOEMFbbu4jSwJe9ILnmneoJrhr1Rdq9GYH7lT5iDIe5WIGlhuh?=
 =?us-ascii?q?xtWjMUqk17pH2kNgpNhoWdPF1qJ4EdyRM/EARmBuYy6DMJMSx6QKW306nWTd?=
 =?us-ascii?q?NN/cLU88aXx65KgyyaLWE8SUdwEESGvnVqeYY18KjcjQpISaI699KyyivEDa?=
 =?us-ascii?q?MfUTpD8x1gO+IC8YTjYf2fUd01gokC/Oa8ZxhzL7tRYZ/AhZvW7MEH3LxHSs?=
 =?us-ascii?q?eqK3YF42o2dJycQTBSABxShHE+kLYfX+ODv5SeYNuSvB4/EiC+mgM7a/TN3C?=
 =?us-ascii?q?ABtJUfhXydmfyoV9E9/Dj3uMefpgjg0a2gW0eFPeBluHMsT?=
X-IronPort-AV: E=Sophos;i="5.92,273,1650945600"; 
   d="scan'208";a="75860348"
Received: from mail-mw2nam04lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2022 04:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liDBpOiSTpTBvpoCrvATDC/uQirYDqWlMy/ngdWWHp9dwn3odQSyLxtw4wZh2sjsnQkKD9v08i2S1BmfIbQVURrbnwG2eNtZNwALWjs5NoBupmo5sWvuUa7B8vg35NGI38k6dqFD07Wuei/2WtwJZwRTgGEMlA5fgQBT/gsrzVdbyZt278m0lRVqA/MFtzjnHYiShKgKdnVGNFMgHUl6yK94y3qdqi7ej5+q1m+tQwjyEpcFQOenaCI93T2+Gv6hxiPvB3Fa1AL5ndxD517iQ+vCN6UkMQtUX4skVBj2zWDnlSQ2rS7Ittf1dBpXmS41xrC0pjo1H90c/agXR6bhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU36mPMvGMR4pFpwKSZ/n9B/7cKnZJksI9dkuvajUUc=;
 b=fiIxxYf30bpZx4LZJ6qKbLNk0uwdFP4VDhI+n5soaQAlEXzthjrPUjaRmOQYenLjAfqanwYrl7qa9cw/wpcyNJWmByncHQeSDZAqiY/XEr5+v39kpgGyV+qSUihWskE3aK6UI4nO+TNLzDHKLJcsEw0Udzl7GpO5MBmsMB4V2ye8BBVcn/ospS8u0kXe42+CA03WoQhn4D3tY4emz5SxbQ/1SwSMFghXdGJ7u6Za8Ok3qLU79FI6fR2g1hemwWTcynPrSpnQUNyr43USDSQNPfuLbVOqTJ+L0qFYHmtRGqRTQU0HOptUkDvQ7ldpT9+B72f5vZ59Q+0LWpqBSfXmkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU36mPMvGMR4pFpwKSZ/n9B/7cKnZJksI9dkuvajUUc=;
 b=haI5A9RBUn7trJiMwh4UaMgmbSltNzhscB0WMJu8+mKgOHHJpXY4aNWF0j3aciUJI9XNkFmWVZw7NZO00Ekd4L00L/eFfXp80CxUJqJrf8C5IHE51p14wwj3aucVFesIWJDOmnG5qf2tvOg6s0IslwSpUdIaiUo84GUcVF5bKYA=
Received: from DM5PR03MB3386.namprd03.prod.outlook.com (2603:10b6:4:46::36) by
 MW4PR03MB6441.namprd03.prod.outlook.com (2603:10b6:303:120::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 08:18:27 +0000
Received: from DM5PR03MB3386.namprd03.prod.outlook.com
 ([fe80::298d:4044:f235:c782]) by DM5PR03MB3386.namprd03.prod.outlook.com
 ([fe80::298d:4044:f235:c782%6]) with mapi id 15.20.5417.026; Fri, 15 Jul 2022
 08:18:27 +0000
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
Subject: Re: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Thread-Topic: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Thread-Index: AQHYlTod5hgtPAUSGEuMopkQlGVYGq189b0AgAImowA=
Date:   Fri, 15 Jul 2022 08:18:27 +0000
Message-ID: <0b5ec408-197c-7e34-28d8-7505e1f031df@citrix.com>
References: <20220711152230.17749-1-jane.malalane@citrix.com>
 <272ea76d-0099-873e-b8a8-1cc43b7b1e11@oracle.com>
In-Reply-To: <272ea76d-0099-873e-b8a8-1cc43b7b1e11@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91ee08e1-0cbe-4651-3301-08da663a9871
x-ms-traffictypediagnostic: MW4PR03MB6441:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5iWb2vyLFf2Nz8CWq4Sx8HdQXyFpQyad8aa969K8YpxORkhYIl7fJ64d4TrEFVQIAb6gxG9Es6/n+hAb5EKiQ57BgUGrMxhlFHvKFVopxNkG9+64wjg8F+LTecSyaqN7BXDdOF7Mo30g4f704MGQKdPWAVdah/g+Knl7aMe+vhe7byWX2dzFX1YQjr4DRGdzmbgdOLmYxPpo/lpvcC5sOujLAcOtZBsVk/eE3WrDtL95Y2WYuT14CYCH/yA0QKV+W4OWJ4LV2gC1MXz3d4m17FyCfc+O6bKrX5A4OF65T3QNzH5YhpMziZPNi/5wCLe/s9lgJkRzUDP63s4TmbjHLMXndOmzko4TiTWz2gG3Neuf2jY1ZZFiutqy7vELIzev09CmtVVCvij8WTIpu6EoCXprZnGimGY2uQy9p8Cvcz67llWMoqNjMB/9zeugcDiU/cV9N1b8tWZonecn318fOJ5MU01wl3/l3dHCOTRxdy03g6HEI0uT7rnU1+bynlcTZ5Lj0NjoSum75S3viAIKba2PDf7fFQLv2yz5nKNe3BKJSZqdQd5Yq6YmA9PYnbv/6IYhsird8SCnQRpHV99zQMv6gzsnS3nwY2IJpGI26CzliRMXjOFFfoYTF95mTgTKCyDECPUIyBURb5toys8TOYkGebQ/xevXzzhe2paOG8FE1hlbDgAzcPaMGPAcjVskXoULCYjqLM3lukUb0tLrHPJT5ijvGmy448FmANPKKcd9rshYb8PjEiy2N1mgyREnmKBt+jJWT0pBXzox+gwNxOhwQFiBkNddql3JPCEjncbYghbRxn2bnk1mol7NnvlMPJvvKJvBGHSqmTocFDaUrE5wWo2fKT0R4VK14Kl6DkI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR03MB3386.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(478600001)(6506007)(86362001)(64756008)(6486002)(54906003)(66556008)(122000001)(76116006)(53546011)(66446008)(66476007)(5660300002)(110136005)(6512007)(41300700001)(91956017)(26005)(66946007)(38100700002)(316002)(71200400001)(36756003)(38070700005)(83380400001)(8676002)(31686004)(31696002)(8936002)(7416002)(2906002)(4326008)(82960400001)(186003)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjJaaFp2eEo2NWxXV1NkYUZKL3QwSnplTWJBQmNONVRualVVVnllSmhnZEFG?=
 =?utf-8?B?WTdybEJFY0ZrS3V0MlQ4QlQ5NWlnVXVWaWRWU0Y0cyt6L3BMa21wYlVPRVJi?=
 =?utf-8?B?YzJoZ0xaQUFzM0wwRjEyN0JGYVdUTjl5cndSQUhDZk5WcGpmN3RtZUpHaUJ1?=
 =?utf-8?B?bmYzWEZEVXNITStsNHJaeTdEeGpFRkpkUXVLd2FibXQ3WHhRckF3d1JyRXB3?=
 =?utf-8?B?WFlWdjRSSXdER1A4Z1VISmRTRlF4dW53eGhNM1FIczR5SUcyUHJNOFc1Nk8r?=
 =?utf-8?B?UlkwaXAwdkV2aGdnS0lkZ3ZCQ3B2Nm5VRi9NSmFhcWhUNWt4QWFGZzVuRWF5?=
 =?utf-8?B?YTUxYStWVzA3MFlmNkkyVjlPdjc2Mmw2TVpaN0YxNXdmU1ZzNjg4bGJBUi90?=
 =?utf-8?B?MXZTTnZiQ0ludE0rNmRiaUFmNWFDVld3YitYV0dnVnJCT044NDlhQ2NYL2NZ?=
 =?utf-8?B?N3VhZmpWcUtsWWx1WFg0ZmZEOGNJdldLUkRGSkJQOUtXcmh0UHEwMFJtNm9V?=
 =?utf-8?B?RThkeHpSRFFhc3FNeEtlTmFvUVM0T0JpV05GK2tDN093aHVVbUFXMG1NK3JJ?=
 =?utf-8?B?c3BQcy9jSVlhbjdGcnV6bWtlV2NnOVpoOVk2RlpOZk1KVk44bGo5dzZWTG9M?=
 =?utf-8?B?R0Nuc2U3bldrUzJvOENVT2FISGtBOHZoNWFSNHU0a3hVNVJ2OHU3WFZJNVU2?=
 =?utf-8?B?djg0c2N4dnl4YjlqMDIwWjFTUEFvS0pTWmVuUmJRdmYyR3loODgzeTVIUncv?=
 =?utf-8?B?SnAzUzY5dWx5VnMvU1R1WFJnRGNDVld0UWJWRlJKQzFhb1FXOEVKcm9rUFJp?=
 =?utf-8?B?WmNzbEFjenl4OEJnVWFwdGorMzl3NXhHNDgwMGNhNFRUMkt5cDkwaHViM2Vt?=
 =?utf-8?B?bzBSZUtzYW5BdmZsTERwczB1QVMxT3o2UDFZaTRQNkF2VUthanZhcUlkemxs?=
 =?utf-8?B?VFk3M21uWFZkbThWTU5xaGg5aEFaalNNV2FzVnBxYmZJTE5wYTlDV2NRT1gy?=
 =?utf-8?B?UHl6OGFFdWMvMXEwL0JneEpsV2ErSXZyS0V4a0gvZFliTUYzM2ErWjVlclcz?=
 =?utf-8?B?UVh0MHFWQjFRaERaTloyZ3AzOTFuRkdLQ24rSldTRzFSQm13TWJoMS9SS1k1?=
 =?utf-8?B?b1FYdTBNQm8rK0pHM1hGYkVJMkk4MUVNZWVFUVdKaFI0cjRzZzhUaXVKVGNV?=
 =?utf-8?B?K1lMU2l4azkvcUo2N3hubHczR3Rkb0JwZzdSSVpFYVp1Zy9ZWUFNN1BjL0ZN?=
 =?utf-8?B?akRNRGVwcDRNeUdVTmNSM0JuM2VZaWlaRVg5OHUyb3JPQjhOZnppYUJHdjVr?=
 =?utf-8?B?ZUpUTEt0Q1BtRnNZZmRhUFJEcGh2bnJseW1FYkNIc0ovTmh1Zi96SzNEaDBF?=
 =?utf-8?B?b3RpWVRYYmVGTm9BYWptWllGSWtqdWRHejhTMXJnUEMvRkYwLzFzYi9mbmNv?=
 =?utf-8?B?cE92OUZBSXNzYXAyK1pYVmxuaytxMzRTV0xwOUZZQW1tcnJVZldBQjdmV2Jx?=
 =?utf-8?B?WDZEelgxeXFsUVBlNUl3TmhxeXdZVlFaL1NPZEgxdk1XZHBYVXVGUXdZa0Mv?=
 =?utf-8?B?Zm9BL0tzUnE3U1lvV1RVQ2NNSTlxREI3M2J5aWdzYXdwWDRxM3pjOFpQRm1D?=
 =?utf-8?B?NTNVMExQZ1ZuVERuaXpERC9vTzdKYVo4T3ltSGV3a1VJRVJIbE9rWG8rVXVz?=
 =?utf-8?B?UVRkRHBMRmlIcm1NQjVuemxXSGhPeU5sYUhwcEFLaG5ubDlKbUhQT3NqYlBO?=
 =?utf-8?B?ODF1TzVDWEFqYVpicUhrWnF1aEtQVFpSQm1QQkkzQnhKV2JrVnliNkpBc2Jt?=
 =?utf-8?B?L1U5WVg1cXgwVm1LK1NNRWJiR0RTaktnU2Qzbm9QZ3N5VFNRbDBCcVRrcjVT?=
 =?utf-8?B?YXBJTmNaVnZCZmtVeGE1L21qYXRTOEJmNGpySld3bHhEZU9pNlEyTGRHNk14?=
 =?utf-8?B?S2NwZjZteUJHWlBJbjVzSHNYQnduUmI2YVN1T0FYVGNFVXd5T3NVNjFJcml4?=
 =?utf-8?B?WVdzdDcyUm5vWXk4ZzBEQlZWbU5iQWNFYzllNFUveDlHaHdKMFBEeStrSnpT?=
 =?utf-8?B?Qk9aN2E1SllENmcxTDE1WkxHUXA0em1YQ242cmJReENycGdrYmpMcUEyNnA5?=
 =?utf-8?B?UXlMSTZycERkNWdjZWphRUoxVHR5NzkrTVdOQUYrd3hFYW9NblY3VzBoTUIz?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27ECB359466807499E59DD4C032E2466@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR03MB3386.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ee08e1-0cbe-4651-3301-08da663a9871
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 08:18:27.7569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMs+mqy1hB+SFhCPFcT9AYZO7xOyDEv4d2UAT0Nl5kjES9TDWtoMDiJ/kB+wmqJqziqGAh/H9nK7x3VxAy/bvAraV74FkfkgcIz3ft7/Mbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6441
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMDcvMjAyMiAwMDoyNywgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPiBbQ0FVVElPTiAt
IEVYVEVSTkFMIEVNQUlMXSBETyBOT1QgcmVwbHksIGNsaWNrIGxpbmtzLCBvciBvcGVuIA0KPiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBhbmQga25vdyB0
aGUgY29udGVudCBpcyANCj4gc2FmZS4NCj4gDQo+IE9uIDcvMTEvMjIgMTE6MjIgQU0sIEphbmUg
TWFsYWxhbmUgd3JvdGU6DQo+PiAtLS0gYS9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX2h2bS5jDQo+
PiArKysgYi9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX2h2bS5jDQo+PiBAQCAtNyw2ICs3LDcgQEAN
Cj4+IMKgICNpbmNsdWRlIDx4ZW4vZmVhdHVyZXMuaD4NCj4+IMKgICNpbmNsdWRlIDx4ZW4vZXZl
bnRzLmg+DQo+PiArI2luY2x1ZGUgPHhlbi9pbnRlcmZhY2UvaHZtL2h2bV9vcC5oPg0KPj4gwqAg
I2luY2x1ZGUgPHhlbi9pbnRlcmZhY2UvbWVtb3J5Lmg+DQo+PiDCoCAjaW5jbHVkZSA8YXNtL2Fw
aWMuaD4NCj4+IEBAIC0zMCw2ICszMSw5IEBADQo+PiDCoCBzdGF0aWMgdW5zaWduZWQgbG9uZyBz
aGFyZWRfaW5mb19wZm47DQo+PiArX19yb19hZnRlcl9pbml0IGJvb2wgeGVuX2Fja191cGNhbGw7
DQo+PiArRVhQT1JUX1NZTUJPTF9HUEwoeGVuX2Fja191cGNhbGwpOw0KPiANCj4gDQo+IFNob3Vs
ZG4ndCB0aGlzIGJlIGNhbGxlZCBzb21ldGhpbmcgbGlrZSB4ZW5fcGVyY3B1X3VwY2FsbD8NClN1
cmUuDQo+IA0KPiANCj4+ICsNCj4+IMKgIHZvaWQgeGVuX2h2bV9pbml0X3NoYXJlZF9pbmZvKHZv
aWQpDQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIHN0cnVjdCB4ZW5fYWRkX3RvX3BoeXNtYXAgeGF0
cDsNCj4+IEBAIC0xMjUsNiArMTI5LDkgQEAgREVGSU5FX0lEVEVOVFJZX1NZU1ZFQyhzeXN2ZWNf
eGVuX2h2bV9jYWxsYmFjaykNCj4+IMKgIHsNCj4+IMKgwqDCoMKgwqAgc3RydWN0IHB0X3JlZ3Mg
Km9sZF9yZWdzID0gc2V0X2lycV9yZWdzKHJlZ3MpOw0KPj4gK8KgwqDCoCBpZiAoeGVuX2Fja191
cGNhbGwpDQo+PiArwqDCoMKgwqDCoMKgwqAgYWNrX0FQSUNfaXJxKCk7DQo+PiArDQo+PiDCoMKg
wqDCoMKgIGluY19pcnFfc3RhdChpcnFfaHZfY2FsbGJhY2tfY291bnQpOw0KPj4gwqDCoMKgwqDC
oCB4ZW5faHZtX2V2dGNobl9kb191cGNhbGwoKTsNCj4+IEBAIC0xNjgsNiArMTc1LDE1IEBAIHN0
YXRpYyBpbnQgeGVuX2NwdV91cF9wcmVwYXJlX2h2bSh1bnNpZ25lZCBpbnQgY3B1KQ0KPj4gwqDC
oMKgwqDCoCBpZiAoIXhlbl9oYXZlX3ZlY3Rvcl9jYWxsYmFjaykNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gMDsNCj4+ICvCoMKgwqAgaWYgKHhlbl9hY2tfdXBjYWxsKSB7DQo+PiArwqDC
oMKgwqDCoMKgwqAgeGVuX2h2bV9ldnRjaG5fdXBjYWxsX3ZlY3Rvcl90IG9wID0gew0KPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLnZlY3RvciA9IEhZUEVSVklTT1JfQ0FMTEJBQ0tfVkVDVE9S
LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnZjcHUgPSBwZXJfY3B1KHhlbl92Y3B1X2lk
LCBjcHUpLA0KPj4gK8KgwqDCoMKgwqDCoMKgIH07DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAg
QlVHX09OKEhZUEVSVklTT1JfaHZtX29wKEhWTU9QX3NldF9ldnRjaG5fdXBjYWxsX3ZlY3Rvciwg
Jm9wKSk7DQo+IA0KPiANCj4gRG9lcyB0aGlzIGhhdmUgdG8gYmUgZmF0YWw/IENhbid0IHdlIGp1
c3QgZmFpbCBicmluZ2luZyB0aGlzIHZjcHUgdXA/DQpZZXMsIHdpbGwgYW1lbmQuDQo+IA0KPiAN
Cj4+ICvCoMKgwqAgfQ0KPj4gKw0KPj4gwqDCoMKgwqDCoCBpZiAoeGVuX2ZlYXR1cmUoWEVORkVB
VF9odm1fc2FmZV9wdmNsb2NrKSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5fc2V0dXBfdGlt
ZXIoY3B1KTsNCj4+IEBAIC0yMTEsOCArMjI3LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHhlbl9o
dm1fZ3Vlc3RfaW5pdCh2b2lkKQ0KPj4gwqDCoMKgwqDCoCB4ZW5fcGFuaWNfaGFuZGxlcl9pbml0
KCk7DQo+PiAtwqDCoMKgIGlmICghbm9fdmVjdG9yX2NhbGxiYWNrICYmIHhlbl9mZWF0dXJlKFhF
TkZFQVRfaHZtX2NhbGxiYWNrX3ZlY3RvcikpDQo+PiAtwqDCoMKgwqDCoMKgwqAgeGVuX2hhdmVf
dmVjdG9yX2NhbGxiYWNrID0gMTsNCj4+ICvCoMKgwqAgeGVuX2hhdmVfdmVjdG9yX2NhbGxiYWNr
ID0gIW5vX3ZlY3Rvcl9jYWxsYmFjazsNCj4gDQo+IA0KPiBDYW4gd2UgZ2V0IHJpZCBvZiBvbmUg
b2YgdGhvc2UgdHdvIHZhcmlhYmxlcyB0aGVuPw0KSSdsbCByZW1vdmUgbm9fdmVjdG9yX2NhbGxi
YWNrIGZvciBsZXNzIGNvZGUgY2hhbmdlcy4NCj4gDQo+IA0KPj4gwqDCoMKgwqDCoCB4ZW5faHZt
X3NtcF9pbml0KCk7DQo+PiDCoMKgwqDCoMKgIFdBUk5fT04oeGVuX2NwdWhwX3NldHVwKHhlbl9j
cHVfdXBfcHJlcGFyZV9odm0sIHhlbl9jcHVfZGVhZF9odm0pKTsNCj4+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni94ZW4vc3VzcGVuZF9odm0uYyBiL2FyY2gveDg2L3hlbi9zdXNwZW5kX2h2bS5jDQo+
PiBpbmRleCA5ZDU0OGIwYzc3MmYuLmJlNjZlMDI3ZWYyOCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gv
eDg2L3hlbi9zdXNwZW5kX2h2bS5jDQo+PiArKysgYi9hcmNoL3g4Ni94ZW4vc3VzcGVuZF9odm0u
Yw0KPj4gQEAgLTUsNiArNSw3IEBADQo+PiDCoCAjaW5jbHVkZSA8eGVuL2h2bS5oPg0KPj4gwqAg
I2luY2x1ZGUgPHhlbi9mZWF0dXJlcy5oPg0KPj4gwqAgI2luY2x1ZGUgPHhlbi9pbnRlcmZhY2Uv
ZmVhdHVyZXMuaD4NCj4+ICsjaW5jbHVkZSA8eGVuL2V2ZW50cy5oPg0KPj4gwqAgI2luY2x1ZGUg
Inhlbi1vcHMuaCINCj4+IEBAIC0xNCw2ICsxNSwyMyBAQCB2b2lkIHhlbl9odm1fcG9zdF9zdXNw
ZW5kKGludCBzdXNwZW5kX2NhbmNlbGxlZCkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5faHZt
X2luaXRfc2hhcmVkX2luZm8oKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5fdmNwdV9yZXN0
b3JlKCk7DQo+PiDCoMKgwqDCoMKgIH0NCj4+IC3CoMKgwqAgeGVuX3NldHVwX2NhbGxiYWNrX3Zl
Y3RvcigpOw0KPj4gK8KgwqDCoCBpZiAoeGVuX2Fja191cGNhbGwpIHsNCj4+ICvCoMKgwqDCoMKg
wqDCoCB1bnNpZ25lZCBpbnQgY3B1Ow0KPj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgIGZvcl9lYWNo
X29ubGluZV9jcHUoY3B1KSB7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5faHZtX2V2
dGNobl91cGNhbGxfdmVjdG9yX3Qgb3AgPSB7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLnZlY3RvciA9IEhZUEVSVklTT1JfQ0FMTEJBQ0tfVkVDVE9SLA0KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC52Y3B1ID0gcGVyX2NwdSh4
ZW5fdmNwdV9pZCwgY3B1KSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07DQo+PiArDQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVUdfT04oSFlQRVJWSVNPUl9odm1fb3AoSFZNT1Bf
c2V0X2V2dGNobl91cGNhbGxfdmVjdG9yLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmb3ApKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC8qIFRyaWNrIHRvb2xzdGFjayB0byB0aGluayB3ZSBhcmUgZW5saWdodGVuZWQuICovDQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWNwdSkNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgQlVHX09OKHhlbl9zZXRfY2FsbGJhY2tfdmlhKDEpKTsNCj4gDQo+IA0KPiBX
aGF0IGFyZSB5b3UgdHJ5aW5nIHRvIG1ha2UgdGhlIHRvb2xzdGFjayBhd2FyZSBvZj8gVGhhdCB3
ZSBoYXZlICphKiANCj4gY2FsbGJhY2sgKGVpdGhlciBnbG9iYWwgb3IgcGVyY3B1KT8NClllcywg
c3BlY2lmaWNhbGx5IGZvciB0aGUgY2hlY2sgaW4gbGlieGxfX2RvbWFpbl9wdmNvbnRyb2xfYXZh
aWxhYmxlLg0KPiANCj4gDQo+IEJUVywgeW91IGNhbiB0YWtlIGl0IG91dCB0aGUgbG9vcC4gQW5k
IG1heWJlIEBvcCBkZWZpbml0aW9uIHRvbywgZXhjZXB0IA0KPiBmb3IgLnZjcHUgYXNzaWdubWVu
dC4NCj4gDQo+IA0KPj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4+ICvCoMKgwqAgfSBlbHNlIHsNCj4+
ICvCoMKgwqDCoMKgwqDCoCB4ZW5fc2V0dXBfY2FsbGJhY2tfdmVjdG9yKCk7DQo+PiArwqDCoMKg
IH0NCj4+IMKgwqDCoMKgwqAgeGVuX3VucGx1Z19lbXVsYXRlZF9kZXZpY2VzKCk7DQo+PiDCoCB9
DQo+IA0KPiANCj4gLWJvcmlzDQo+IA0KPiANCg0KVGhhbmsgeW91LA0KDQpKYW5lLg==
