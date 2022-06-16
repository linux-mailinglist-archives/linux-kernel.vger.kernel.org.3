Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE87C54DD9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376460AbiFPIxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376926AbiFPIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:53:37 -0400
X-Greylist: delayed 115 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 01:51:37 PDT
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147605EBF7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1655369498;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fLJ/1BCNMT7a26LAEsyfKBEGOYqfOjKVa9uNnWC3Az4=;
  b=KN/D1JsaGSDWjPfmA28D2u5la9/TK7AIuF9OaprxocAnaLCCsfQ2iyND
   jsKplslRr8AVTtSBmXkMOY6aGgKMgQox9HLfaerp2GNvz/sksc3dj0qOY
   QUrvTbvwcmFQCtdJjdkeM87UjCNrJ9s/FYoC+gQQQAgYTF9MIrw0YpalJ
   w=;
X-IronPort-RemoteIP: 104.47.58.172
X-IronPort-MID: 73082122
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:ehFWMqzwpH3nKrQMqVd6t+fLxyrEfRIJ4+MujC+fZmUNrF6WrkUFy
 WFLX2HTPvmDYjb2co9/at/lo0xQ78TcydFkSAFqqyAxQypGp/SeCIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bv656yMUOZigHtIQMsadUsxKbVIiGX5JZS5LwbZj2NY22IbhWmthh
 PupyyHhEA79s9JLGjp8B5Kr8HuDa9yr5Vv0FnRnDRx6lAe2e0s9VfrzFonoR5fMeaFGH/bSe
 gr25OrRElU1XfsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0qS2TV1hUp/0l20c95NJ
 Npl7Jy7ED4oE6P3qc9HYxoAPQ5MBasd9+qSSZS/mZT7I0zuVVLJmqwrJmdmeIoS96BwHH1E8
 uEeJHYVdBefiumqwbW9DO5xmsAkK8qtN4Qa0p1i5WiBUbB6HtaeE+OTuoUwMDQY36iiGd7EY
 MUUc3x3ZQnoaBxTIFYHTpk5mY9Eg1GgKGUI8gvP/8Lb5UD3xktP/KbsP+DvXfu6a51rsRiW/
 kP/qjGR7hYycYb3JSC+2mm3mubFkCf/WYQTPL617PhnhBuU3GN7IBoSWFigveiiimaxXtteL
 wof/S9Ghbg/8gmnQ8fwWzW8oWWYpVgMVtxICeo45QqRjK3O7G6xAmkCUy4Ea9E8ssIybSIl2
 0XPnN7zAzFr9rqPRhq18bOZrii7PyQPGnMTfi8PTQYD4N7LrZk6i1TESdMLOKSylNzuXzbr3
 yqNsjM9lp0Ul8cA06j99lfC6xquqYLOVRUd/RjMUySu6QYRTIy4Y42l73DL4PAGK5yWJmRtp
 1ABksmaqeoIXZeEkXXURP1XRe7zofGYLDfbnFhjWYE78Cig8GKieoYW5yxiIEBuMYAPfjqBj
 FLvhD69LaR7ZBOCBZKbqaroYyj25cAMzejYa80=
IronPort-HdrOrdr: A9a23:DCM+EKpc/VPf7C22khEIzqUaV5u3L9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssREb9uxo9pPwJE800aQFmbX5XI3SJTUO3VHFEGgM1+vfKlHbak7DH6tmpN
 xdmstFeaHN5DpB/KHHCWCDer5PoeVvsprY49s2p00dMD2CAJsQizuRZDzrcHGfE2J9dOAE/d
 enl7x6jgvlXU5SQtWwB3EDUeSGj9rXlKj+aRpDIxI88gGBgR6h9ba/SnGjr18jegIK5Y1n3X
 nOkgT/6Knmm/anyiXE32uWy5hNgtPuxvZKGcTJoMkILTfHjBquee1aKvS/lQFwhNvqxEchkd
 HKrRtlF8Nv60nJdmXwmhfp0xmI6kda11bSjXujxVfzq83wQzw3T+Bbg5hCTxff4008+Plhza
 NixQuixtZqJCKFuB64y8nDVhlsmEbxi2Eli/Qvg3tWVpZbQKNNrLYY4FheHP47bW/HAbgcYa
 dT5fznlbdrmQvwVQGYgoAv+q3nYp0LJGbIfqBY0fblkAS/nxhCvjklLYIk7zU9HakGOud5Dt
 T/Q9tVfY51P74rhIJGdZM8qJiMexvwqSylChPjHX3XUIc6Blnql7nbpJ0I2cDCQu168HJ1ou
 WLbG9l
X-IronPort-AV: E=Sophos;i="5.91,304,1647316800"; 
   d="scan'208";a="73082122"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 04:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+y1kzb/rUnRZCpySi9IVUFsbeVZ3dbHcJRpBuEm74nbUhCSA211d98me6MZCjbZF/xxVKK44thVDysA8FHmtfihdyfzxFVrUJ+Ndedv5A9kQvqUS7NDYtXnMoQYwDwxtufnqo2aTkjAnab1vZWV3atVefS9AZgCWleEvdS7uRPoYesS+iW0rDlewQ8vr4HjdxpI1GTmPTA233tTMWkmy8G/mxVJOhWz9/wrcp0UaLKHI1jM8AD+Au9cazgzZtXK7w3Qgbslqog4LkwIGqhpBnL6Gx+yuGYwP7YaMq5lIVKl4GXrb+L6+bIUYZSSCuL0CqWmXNzlLV1btvoHT+v3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cLom0y4HWD07Ic3sPVf5/TfOrMlkRnW1dnPd1g2lys=;
 b=IbLC9PRs3kranqis8T6IzYRG0a5xDAzFIKZOEIKbNzXRrhUSXicNDYsUgkVrgeFg/MvwGwCeK1e9GoUe+29aMJ5Cr+fg8l+T5u7VLJHGdaO7VFJMKeVbWPn6SZDaFedbIFcBt0YOHFdmJfewB/K1+10muJzrKsdRi0djpyMnRo5a8oX/DrScp3f0PkqG7xEtD88wUCoeYloPOCEsSrkBAkYoRk8EQdICDIrREGBlM5Ylc+Hk/tAgcIMPsVtmd4tBPnFuN5w/C+8vtj6C22tSugG7ABSDS0J+Y8B5kr7tDthh4DO11iv+uBa7nWT4zwvM2CS67/b1qANajEQmfy9rug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cLom0y4HWD07Ic3sPVf5/TfOrMlkRnW1dnPd1g2lys=;
 b=aoAfw5RKCIM8x9yB/pNxP+V68kasK6L1MfsrPa458yT73hq1qMb0tQvN32K2y1JTDIZECWWX7uVMMTTAGqJ7YIiQdqRzBSCJIl+iUgaelxMmw4Ldwh33zcFmNk6fuNMy3Ib1jbCpy9wpPG3S7Wb6sBxeb2zy5l07gRK8fE2EdlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from DS7PR03MB5608.namprd03.prod.outlook.com (2603:10b6:5:2c9::18)
 by DS7PR03MB5525.namprd03.prod.outlook.com (2603:10b6:5:2d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Thu, 16 Jun
 2022 08:49:38 +0000
Received: from DS7PR03MB5608.namprd03.prod.outlook.com
 ([fe80::40af:d5f4:95eb:d534]) by DS7PR03MB5608.namprd03.prod.outlook.com
 ([fe80::40af:d5f4:95eb:d534%7]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 08:49:38 +0000
Date:   Thu, 16 Jun 2022 10:49:34 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Oleksandr <olekstysh@gmail.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: Re: [RFC PATCH 1/2] xen/unpopulated-alloc: Introduce helpers for DMA
 allocations
Message-ID: <YqrunrtBjWPgdlDi@Air-de-Roger>
References: <1652810658-27810-1-git-send-email-olekstysh@gmail.com>
 <1652810658-27810-2-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2206031420430.2783803@ubuntu-linux-20-04-desktop>
 <00c14b91-4cf2-179c-749d-593db853e42e@gmail.com>
 <alpine.DEB.2.22.394.2206101709210.756493@ubuntu-linux-20-04-desktop>
 <a51dec23-c543-b571-8047-59f39abb0bee@gmail.com>
 <alpine.DEB.2.22.394.2206141735430.1837490@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2206141735430.1837490@ubuntu-linux-20-04-desktop>
X-ClientProxiedBy: LO2P265CA0120.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::36) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e77ae81-37b2-406b-37e4-08da4f75253d
X-MS-TrafficTypeDiagnostic: DS7PR03MB5525:EE_
X-Microsoft-Antispam-PRVS: <DS7PR03MB5525C131ACEF388EDD4D6F378FAC9@DS7PR03MB5525.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtxHInVo6ayjAezQhvK8Rkw/1+myezAWl141bRnoOclO2A7o9uGBynfYn6zNafwpF6FCLjzRPcDGctiDQoLwm0blvj8RUnsIt5YXwHoOT9TTDUrVD/9t87Znm8kcDmRWqtr8gPpxeVwC2vivhcpQ/wy0WBqKVAUNnWi+MgI5wS8PQDfeuJLcskunN5BxBDyI+EO6IdKTM8IahTXmooWtqTi4fiuGTt+QOGv50r3hPjz4WxHw6C/wzlbelmFW3UYMTU3Tks1u6lToq6iwczfnM3QsYn8n8dBRlNi58XEevPA7M/FZEgo1KbGhfajPdSqalM0MoN4+zj+KstDGgQZkgUKa93kL0jFJkoplr6Gbxvm2EjvUamK+hEUh09kCdf1orkxzfwGpt8pU9aOKwRILrUTnAjSLoyClf1hWXypGa2wX7sLGy5nl3GDM0TIPcmFIvCOSPPzVugu0IXRiysIWKRVwXC2v/XQZa2Z+rYqk3Y3dt2AdDwrlrUkp/cEOY64KLPVpyUuji+uVf7p2VUQmq0++Fkvcz6ZKkxuq7D7w4VAaQ5W0Gx5a2EJG/4VJNhFodKa0ZwNUui0f9EUCMY32b5PmicfhVrAOz6G6eyF9XnZSCnppwlnnPQOnfmTy1aJCzr9JsPcH/ehovtVCUqQcsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(6666004)(85182001)(8936002)(38100700002)(6506007)(33716001)(9686003)(6512007)(26005)(6486002)(54906003)(8676002)(4326008)(186003)(2906002)(5660300002)(508600001)(316002)(6916009)(83380400001)(82960400001)(4744005)(66556008)(66476007)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnUwbWJPa2Y5bEVrdVgrRkQwMXBDQ2hQNUM1YUovejF0RVY5UjNlZ2F3a1pC?=
 =?utf-8?B?Y2gyNjhUVkZNMjdSWVRrZURxQXRxbk9lVFlWc00zWHFPOGErUGhxZ0ZZTzBu?=
 =?utf-8?B?bFV5NFY5ZStOYnR5RlVOQmYyNjNacjJBYW9ZeVRVdHVVRER3dVR0NDAyV2d6?=
 =?utf-8?B?T0tjczNwWkswS2dtOW1DVnJVL3l2OVJVZmU5eEN4T1czRGNLSG5XYm1JTXNT?=
 =?utf-8?B?UldMS2ZZV1JlN096Z1F1OGdLZWdNblN0cmowS1dGRndMRUZwdC82K21KcENw?=
 =?utf-8?B?ZzRFcUZDWTRPWHFMR0JaQmdDMFk5RU1uVy9kdGdDd2xIY1U1bE5PWnFWOHBC?=
 =?utf-8?B?MmxUdGFYSmpJQUUyWXA2cS9tWVNrWHJESGFHd1l5dlBYVUhMVVVLZFNHa0Nl?=
 =?utf-8?B?elJKMjM3MS9rWXJhd1A2Wm42RUV0UWhIcC8zeTM3bE1JY2JXL21pNFBTdzc4?=
 =?utf-8?B?ZXQySnhFVVF4R1lJam9seEZKUE5uZlR6cDNvVGJFRk5yYW1oOVhKYzdVcHlX?=
 =?utf-8?B?ZE9VdnNVdFJlR0JPeXdTM3VVMVR2eFhORUFqQ0NaWm5NQVdRZEs4Z1JXQmdp?=
 =?utf-8?B?ejQ1S3YyaGdGbVBUcUhwYzRKWE5kS1VocGJteGkzamU4NUJiTXpuMHVGYlhB?=
 =?utf-8?B?bm5RaWRJS3FtNG51NzRmVnQxeCtSVzZIcDhrK0FBYlc4QVAvUU9GQUsydXZ6?=
 =?utf-8?B?QTNRWERkT2FkRFlWYzRNVTJVZVJSaXhGalZBckNFbFJrL3dVTnZVY0hjMGZw?=
 =?utf-8?B?bm1xeU5iWUttNzhPYTZ5eGJMYm9kaXF6cnJKTEZMZzR6VDJxS2tTV1hRaDU4?=
 =?utf-8?B?eFFNNkdiVGhKdGtSYWlXOE1GdEpRNkJ1Z2dtOWlvRTFoUTZQZDdwa0hNMFBj?=
 =?utf-8?B?T0U0b2FZS2pDN1l2WVRsVTB6QVVSeVBoSTdIMFdkV3d3SWRwTFRNdVpHdEtl?=
 =?utf-8?B?VytxYk9GRTNWZXhDVy8vTEk4c2RxQnZ0c2dtMzd0M3BQVk1VYVNmcUpyTmg1?=
 =?utf-8?B?SHBTeVB5UHY0K29paEo1cWw4QWVRNkJselpvZ01pV3NVaXdxZUp3aEtodG9a?=
 =?utf-8?B?NlloR1I3QUZhYlVXcjVSTUxEbXJ3dkZpSkhyencyeml3V0VrbUQ2TmRlMXoz?=
 =?utf-8?B?UVhUZkN2Sjd0alhia0tPQzFMejJST2RaUFlEblk1ZThJR3pUK3ZVbkQyMkJa?=
 =?utf-8?B?Qm9ZTzJwcCtpcmtOQlJKN21qWVh6SE5RLzF1c0V1cU9MZFVBTjZrUHJZMklX?=
 =?utf-8?B?RXZqRDZpcEpleDNqMVAxOENtZU9Udkl5QzRDZzdpbGt3dHQrcmk1eDUzb016?=
 =?utf-8?B?aDJLNUFpeGNwR2szT1dsbDA4ZUNVRDlZdGxuaHlDaVNSOS81QVhhR05oRzVo?=
 =?utf-8?B?Z2NMaCtZYzY3WDJTTjBReWkrbWVYNGZKOENBWjFaaUVIdis5WCswNElaVExn?=
 =?utf-8?B?U09EZUpQVHNJREF3c0ZIcjBwRTI1cjhOMWQ0OFJjc012VjdXejF2NXlZNVVM?=
 =?utf-8?B?MkJnVnM1VHRYa01lRVJ0eWw5bkNpSnhRUmduQkRCZVZ1QzFuZjNDVmpuUzRy?=
 =?utf-8?B?WVE3MlN0eGJDZHNEOTJ6MUFLekZRT3lsdDFnK2hRRWZHYkdpbUw3MFlQRHVm?=
 =?utf-8?B?V0xESDVXUjBHU01MMzE3ajJrdG9jUitYYWdMRVNTMlhYZWRkS0R5bjYxWUJS?=
 =?utf-8?B?Z0NSelhpTjFHZ2JSbHhvYlBoVU1MaUdSWWxCbGVwY1VnRG9pWGN4c0dCRVJ2?=
 =?utf-8?B?a01hMjFVeWZFZGxXWHRKdmZuUjVTNzcvWGVLU2NRQmd2aklHWW1rMkJkR2h2?=
 =?utf-8?B?LzlzOWh6Tzc5R2UxS1hOekh6THYwbWZmUFlidy9GODVKVDlZaHkxeFhqems4?=
 =?utf-8?B?Q3Q3MEpseHlnYXRQcXJLa0hnSHgzaG9JVU5kRisxMjU1b2xiR2crMkhrc3Js?=
 =?utf-8?B?ZVZseUg1M2t4S29IcUhhU2E5OE9Gb0xkT3ZrOVd0N1VrRUpDOVozTm55OTJH?=
 =?utf-8?B?TW84ekNkU2V4Q1hrZ0NoalZUdjByTWFIM1pmc0g4ckpDNlRydy9QRGxFVTVI?=
 =?utf-8?B?YjhWOEhhNkUzRFl1aFZLaVZaV3hpTm5ibmU5aGdvamZBSHJFenBGRG9objla?=
 =?utf-8?B?dkI1MXFnTjdFTEw5M2pUK0tHNUlDcHA1UXZWMGIzMGE5bitaZWFTbG1qL2U5?=
 =?utf-8?B?WmcxbTA5cmN6aU55ZGE4RXlhamtsbWlHazJIbS9pT1hhcFBUVUpJTmtJdFpa?=
 =?utf-8?B?NWJOUXpPc1BPUkRyOGdzYWk2S0cybGl4ZTJXa2VrZ1ErVkx1bURTcTliaDBn?=
 =?utf-8?B?em01MWhuaVNUa2hxd2RwNlQ3UWZDRVpQSnpaeXMrZElpMk16b3pYSUQwcmZH?=
 =?utf-8?Q?2YboA+rg9jRMv0nk=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e77ae81-37b2-406b-37e4-08da4f75253d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 08:49:38.3213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/uGnLNB6Ktf9E6jRUIHaibTVsrj58ddFnWVl28ewv5vov5wwa1/6YcToQ5T+wa2YBrZQczyZ82Kscvl1DuXWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5525
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:45:53PM -0700, Stefano Stabellini wrote:
> Basically, if we allocate (and free) page-by-page it leads to more
> efficient resource utilization but it is slower. If we allocate larger
> contiguous chunks it is faster but it leads to less efficient resource
> utilization.
> 
> Given that on both x86 and ARM the unpopulated memory resource is
> arbitrarily large, I don't think we need to worry about resource
> utilization. It is not backed by real memory. The only limitation is the
> address space size which is very large.

Well, unpopulated memory will consume memory to populate the related
metadata (ie: struct page and realted tracking information) for the
unpopulated region, so it's not completely free.

Thanks, Roger.
