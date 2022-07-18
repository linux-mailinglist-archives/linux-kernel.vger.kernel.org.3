Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011B0577E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiGRI4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiGRI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:56:22 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15553AE4F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1658134579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mBwG3F2FB9u8m+MzWXH8m4m2+uk9RGt0rE6NNCVZoqU=;
  b=MNqekiA3kSts2t/D30SK5p2oyrirC0wl62MGJ+14X+GDGXRX+W54S2Zg
   dA1gTol9XQN/kbui7wBG3IMxTcEqqzO2W9hO1JbpQhDXdomotVrQoHE+G
   XDH/eo/wfLcOlAUj7HqOTSxeO93IvlroDx1dyO0P92dhGvCO/EP3aUvGd
   Y=;
X-IronPort-RemoteIP: 104.47.57.46
X-IronPort-MID: 76448307
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:gG/Jg66kY2j+nwvayCwlUAxRtBbHchMFZxGqfqrLsTDasY5as4F+v
 mUcWmGPa/6IZ2Kne9t/b4u0/UwHvJ/dyddhSwJvrC43Hi5G8cbLO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG96yM6jclkf5KkYMbcICd9WAR4fykojBNnioYRj5VhxNO0GGthg
 /uryyHkEALjimQc3l48sfrZ8ksw5auq4lv0g3RlDRx1lA6G/5UqJMp3yZGZdxPQXoRSF+imc
 OfPpJnRErTxpkpF5nuNy94XQ2VSKlLgFVHmZkl+AsBOtiNqtC0qupvXAdJHAathZ5dlqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJBsubNU7ufd+Onh10
 9M/JxEIdA2ThMvjldpXSsE07igiBO/CGdtF/0pGlHTeB/tgRo3fSaLX49MexC03ms1FAffZY
 YwedCZraxPDJRZIPz/7CrpnxLvu2ia5LmIe9Az9SakfugA/yCRY1rT3PcWTUduNXchPxW6Tp
 37c/nS/CRYfXDCa4WXbri783beQ9c/9cNogBpC37/xzuXy8xWIOKiRLXmORjfbs3yZSXPoac
 ST44BEGp68o9VftScLhRRqmu32VlhkGUtFUHqsx7wTl4q7V5RuJQ2sJVDhMbPQ4u8IsAz8nz
 FmEm5XuHzMHmL+aU3WG7Z+PsCi/fyMSKAcqeSAAXSMB4t/+vJs0iBPfCNpueIawj9v6Hhnqz
 jyKpTR4jLIW5eYBz42y+VHKhWLqqpWhZgI8+AiRXmuj9Q5/TIqkYZG4r1nd8ftEao2eSzGpr
 Chas8uT9uYDCdeKjiPlaOUVFZm79uqCKnvXhlsHN4I66z2n9nqnfIZRyDJzPkFkNoADYzCBS
 EjXtABK7ZlfJky2fLR3aIK8Dcct5aX4HNGjXffRBvJLYpVgcgKv9SRnd0mWmWzg+GAum6wiP
 ZaQce63EG0XT69gyVKeTOAZ0LltxSE4ykvSQ4z2y1Ks1r/2TG6YT/IJPUWDasg97biYu0PF/
 tBHLcyIxh5DFurkbUHqHZU7KFkLKT0gA8n/rcVSLrSHOlA+RD9nDOLNy7Q8fYAjh75SiurD4
 nC6XAlf1Ub7gnrEbw6NbxiPdY/SYHq2llpjVQREALpi8yJ7CWpzxM/zr6cKQIQ=
IronPort-HdrOrdr: A9a23:y0sgI6BJ57fuIw7lHegPsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U0ssHFJo6HiBEEZKUmsuKKdkrNhR4tKOzOW9FdATbsSp7cKpgeNJ8SQzJ876U
 4NSclD4ZjLfCBHZKXBkUaF+rQbsb+6GcmT7I+woUuFDzsaEp2IhD0JaDpzZ3cGIDWucqBJca
 Z0iPAmmxOQPVAsKuirDHgMWObO4/fRkoj9XBIADxk7rCGTkDKB8tfBYlml9yZbdwkK7aYp8G
 DDnQC8zL6kqeuHxhjV0HKWx4hKmeHm1sBICKW3+4gow3TX+0WVjbZaKvi/VQMO0aWSAZER4Z
 7xSiIbToZOArXqDyeISFXWqlDdOX0VmgLfIBej8AfeSIrCNXwH4oN69PxkmlGy0TtegPhslK
 1MxG6XrJxREFfJmzn8/cHBU1VwmlOzumdKq59bs5Vza/poVFZql/1owGpFVJMbWC7q4oEuF+
 djSMna+fZNaFufK3TUpHNmztCgVmk6Wk7ueDlIhuWFlzxN2HxpxUoRw8IS2n8G6ZImUpFBo+
 DJKL5hmr1CRtIfKah9GOACS82qDXGle2OFDEuCZVD8UK0XMXPErJD6pL0z+eGxYZQNiIA/nZ
 zQOWkowVLau3iefPFm8Kc7giwlGl/NLAgF4vsulKRRq/n7WKfhNzGFRRQnj9agys9vcPHmZw
 ==
X-IronPort-AV: E=Sophos;i="5.92,280,1650945600"; 
   d="scan'208";a="76448307"
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2022 04:56:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdLGIXfL5j0vcTKVDzlibj/CmrO4+IxIzNbAaO3Gdz1S7qmU45W+3a/gy0sGRUeandYubQQL7QMPhJh7e3ASi8pvhxiZfiOtstGJJZuzJFMZOnsNzfjDc4wmSVpV/w2SJYSRuBmMH7N4cVWeaBihZQbJu9BdpNuPK3ngVlCn1sWAV2lNh4yURecGnjjwZgV8ZP6i5iN2fownXVYXgThnVzFyvxMINDeDLz5+0GUqwuUxQiULTbgqT9CnRdvHa2N/CiJAVVcWvaP7QJzLIODnfPtTzscm1EXSaeRYrbstm11aeVFwAs42f3+1MCMcrO4bXVeXkxsWtC3S/cfnqf5sHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBwG3F2FB9u8m+MzWXH8m4m2+uk9RGt0rE6NNCVZoqU=;
 b=ERpR2KonXn306P0Neh1MtspCFJxPHacwl4tMY1+VjxZBTUBGbF2LbstJXOxzihau7KDy8lR6AGHitwKEufTN88bdJCYDkOI6+l1RqyoKG0SXlBG/HJ5DJ7LMWbiXNdkhBpcvPVKXfftT9J8GioX1x6PiZrw5LFVN5pwfGHGLQbRgDGE2fbWVTbtAUR/zbzfWlk4HNHCPgaLl2/tBxBz2Di0Z/80VStQarQxuGwvl2POaZ2WPLw26LnA8TZmJVR1hW38xcVB2xl9mi4ECIqdp3zbEAtz+4kvSudcJ8L2yIU+gWBorqtmzYidpHssdORAVTRD6EwUzL7/Tic/qimsUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBwG3F2FB9u8m+MzWXH8m4m2+uk9RGt0rE6NNCVZoqU=;
 b=YEa0fYm5Bqn5DWrcD7FQ0KzXadebjv9k7zeWf6enN8W0KryWkGvtBHORXS1rBqgRZX41RTyfHFSywtU+jTxkaAKXFpNksOMuxMSyTx0LKaiilcxvT431udnpGcq4ro4CzNktX/aITPeHUTxAlUCf/yKq/369Frj561qeS6OiMPw=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DS7PR03MB5624.namprd03.prod.outlook.com (2603:10b6:5:2d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Mon, 18 Jul
 2022 08:56:03 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c%4]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 08:56:02 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jane Malalane <Jane.Malalane@citrix.com>,
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
Thread-Index: AQHYlToncjhzapb0rEGq8Bkg0N3t9a189b0AgAImuYCAABmhgIAAOBoAgARvxAA=
Date:   Mon, 18 Jul 2022 08:56:02 +0000
Message-ID: <c9aafc28-e93f-ebe4-b591-0edab4efdf2b@citrix.com>
References: <20220711152230.17749-1-jane.malalane@citrix.com>
 <272ea76d-0099-873e-b8a8-1cc43b7b1e11@oracle.com>
 <0b5ec408-197c-7e34-28d8-7505e1f031df@citrix.com>
 <01cc9e39-242a-3cbf-13b3-cb3ecccd5737@citrix.com>
 <3be61417-6e58-1d9f-dd3c-7de00daa8d0a@oracle.com>
In-Reply-To: <3be61417-6e58-1d9f-dd3c-7de00daa8d0a@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2183091-8aad-4acb-ae9f-08da689b57b7
x-ms-traffictypediagnostic: DS7PR03MB5624:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GWecnd1aESU04Cz3dwR55Ta8eb8QmxwBSD/qew5hNW5b7WyNgQ0nWz8EkDmkUTH9mZk450fVUJBkoqeqd3QlgA8JDuJrRoPXifYGCzUIAJ01KlYzlzCgsNgRA6XbTHCEZ8+OqFFVyZoAY50x82S7i+05n+3OQErULw2VtVOctCIt51EIZK85U9hWrwRqIWLCMb6Q2rsiWjvUwh0ZQB00cauGenvNeirFglNXoyP8fyqhS0dn0Fz4bIQfyPAVaKjNguCB+CnaORvBQm61LTLpmH5vNbnrSwl2VZas2VgdoUfbt9PwAvzO46JphOTEQ5Sf9LRHwNCGbHpCKt8MINNVxtdoMc9whRa/P2Xf+exkoyXjCBlB1RThvq3uTmslBo7AEUeCyEnPeILXibsAl8OTKBq0XMf6hUBOaY7RSQNrheRuE/4R9gr6V9izICnqPLdj9T3K+ZQoyAyJx0tsqvfiOkGDMrAmP/aQ9GiG6Jy73mOK92zRwQIY1yCYTWN9GuY/H6UfhGgXGBdEl94SaWk2xx/xtbi3NPU3Kbk7yz3JqKlS3pJpILz5a2FjNVhA4uDuexgROLffERfyg0Yn7W+CilnZyXzZGjPRgdTHQgqOgOKoe/wM2i/aL0XAFCjcjnwaHxcZU4ByJlDi+dXSrqkMYYKcRR7sA80uKv8x5dFWHv1+ZHN31wttFUkcs7qpJ2eOp2/Z4RHS8FlPThJ/Z0wJC2tht65AuadOONM4TbXQ2ZxdNENCT0nTh+fxyHzkTbqD3yjtgBcH+f/cqXoYKENFDrBIw71bsPwtstDK3O/R+QQYGGzLQgWuJuGJdgMukeC6d6dx7hV4Cn4ttHVwVOqfB120d5IRXX1Kjkf1CySj0D2+v1oLTJ1dkHGt3r7UmFRT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(71200400001)(76116006)(2616005)(91956017)(64756008)(66446008)(2906002)(4326008)(8676002)(66556008)(66476007)(41300700001)(66946007)(478600001)(5660300002)(7416002)(31696002)(53546011)(6486002)(6506007)(26005)(6512007)(54906003)(86362001)(8936002)(31686004)(316002)(36756003)(122000001)(82960400001)(38100700002)(110136005)(83380400001)(186003)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ry9mZFhqWGEzQk9jTXhOVnNWNDFsbnQ1aUFmOUNianB3MjYrSU5hd1dzZXBR?=
 =?utf-8?B?ZHgrbHRnQWdFc0VqNkJ6Q1BKY1NJQmYwc3pPSHhZbWFwTXpzQzFBa3hYcWV3?=
 =?utf-8?B?dk0zZ0pCSXVMclZkaHVXWlJSWTRpUXkrVGJ6cmNQY1NabGtaNXRoalZ2bXgx?=
 =?utf-8?B?N1gxMnc1VitXWUJMbUhhYzQxQjhHWi9mS3FuT3FsUGhuYUVFZDF2cWhhUjJn?=
 =?utf-8?B?TU5SNDZBc2Y5MkZlVVFzNFBHb25NWGVoczBtMEpTSXdDajNiLzFsWU9aV1Ns?=
 =?utf-8?B?N2hGNzNUUVp3ZDhBME11RTExVHl0VVdlZ25UQWhsWGZiUUNGMkFpb1ZiaGRt?=
 =?utf-8?B?OHJyV3ZiVmgrZDNWbHBCWGgvMlJseVYvZlhaOFZURXEyS2diS2xOR1NPamZZ?=
 =?utf-8?B?WWNxdTh2cEVid3VjOTcvY3g3RVA0dko2UHlyb2RHNitUbkZVM3VWWUVXUWpZ?=
 =?utf-8?B?REtiQmFSbVZIeWh6ai9ZMzFrcGRxOGFZWkg5US81OHJUdUJwa1BzMWhyU21y?=
 =?utf-8?B?QXIrYmtDSEplOUIzY1ZMZU5NMXFFN0I4RDZLNm1zSkhGeTgrS1RFSjRqYy9y?=
 =?utf-8?B?WGh2dFhyWllSTWhuTlJ2MjZ0TjBkMDJHMWxXVjhOeWgwZytpNHM5QjlweDV2?=
 =?utf-8?B?WnZaU0RSOHB2OUtMY08ya1NDRkh0TkhobVdhMzh4bmJQTHpVeHdLc28xWUR4?=
 =?utf-8?B?aE05MHV6d1Z5TjVHNHJGSmRFYjh2UDc3UER1Ykw2RFZOVm1yMkZsc2IxazA5?=
 =?utf-8?B?YzhJNDNiR0crdElka0NHZEtNZWpHOVVRVi9QYWoycmhjQWRJM0ttMmM4bitk?=
 =?utf-8?B?U25jZ2tyQXEvOWFsaFhwTTEzNGhicC9yRFlhdGl6WVI4Yld6bXIwU3U0Wmx0?=
 =?utf-8?B?OEFYU01JWVlSVGtaQ2p5MUY4Mmc4MFB4YTZFc1FVQnAzNkFTcWY0U0c1STB2?=
 =?utf-8?B?TnhsNzdlc0JEY0gzUTRFR0wvQ29vNjNQeDNIVlA2QzB1b1MrYk90dXZSTXBx?=
 =?utf-8?B?bmErVDNsWThKVmhHOVh2ZnZvcC9XaG5IeEZEeWZYMFpWckFHdndJdEFUNlRR?=
 =?utf-8?B?Uk53ZGw3cHZkZDgxV1RNNUN0d3I3eUpIQm9pSlcxNldqZUUzdHdKWUlJMFU1?=
 =?utf-8?B?SmhOMTVOZkEvTmh5ZVMzdGVROUpKQ1RBYmNRelkvK1Y2dkhubkJTMzRNUTRh?=
 =?utf-8?B?b1g2QjUvSGg4VmQyRysxTDlGRDI3TWdIeGJPbmp6ekM5ZTVJK1lCODAzaGc3?=
 =?utf-8?B?eFc5VWVOZ205S1NoYWhOcjRZVFRHclNaMjkwREJ5MnZDY0psMWNXMHBEK24w?=
 =?utf-8?B?d3RaeGJVeGllZTNRblNJVCtMbS9HWDJlZ0NkUGlaMkYwbW1tSUlGK0dkNGUz?=
 =?utf-8?B?dytrWmVNRlJtUXp5TFNIT0NFblMwRlhTZzdvRzNmdmwrNGtBSi9jWUtsVjVP?=
 =?utf-8?B?cmI1VitGa2gzYjZacWg5K3FZQ2IyTDNBd2pPaVlRNFVQWE01ZFZpeEJyVWp4?=
 =?utf-8?B?T1F4QWlxY1l2alpINVh1TytMd3p2eW83WTAwa0tQVUhGVzA3eWc5am5ZNy9n?=
 =?utf-8?B?cnBOWll5MEtIOHZmL1lTbURWWEU2dXdYVEc5V0NISnU4YlZMTHBMWExaK3lW?=
 =?utf-8?B?aUZ3dUxYSUdodHp5RjhrVS8xcjhQZXBYaFNta2dQYWRyN3ZvcVpaRks1VkhD?=
 =?utf-8?B?ZTd4bnJUMDZNVE5qOEZQRUthMXExZ0xzdlUwZnEydHVqaFQ3NzdZMW1mclZo?=
 =?utf-8?B?dERBMHIzT0NhNmZ0ZGxZR3ZCRlZmaFBGbzRlMWpFZHM2V0hpclNqZVMvcHVp?=
 =?utf-8?B?ZldMcmJwUTlrd2tLZUFVQ1pvQ1hCdkFJbzJncjlvK01wbTQvc21UL3A0cnRN?=
 =?utf-8?B?eXBJUFk3YlB4RTJ0Vy9qQXZRYkY5ZkJhUU5oMURwN1NxbHpxRDl5WVU3RWhy?=
 =?utf-8?B?aEpnRXZ6ekZOeFEvV1U2TXVBVFlBczhXd2l4SHlwNWw4SFlnUWtzUkx0RE9i?=
 =?utf-8?B?VFpTVjZHSU9VOXBRUjdOZ1RBbHRUNkJCcEhWMzIxL1RxejNyN0xGUTNZOXRY?=
 =?utf-8?B?MFBHTUJKTzF5dmVwOGwyOG12akNadVp1V0dXbXptTkpURlJhVTRDTHphbWpP?=
 =?utf-8?Q?yDqFfm3LEzc9CdDOCHUVBkHSu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <459C3E8FBDC64644A0C3D4D327CB90BF@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2183091-8aad-4acb-ae9f-08da689b57b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 08:56:02.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/5ljpc4lUGy/HaLI5h/5UOLG2cdvsLoe9xPaaVyPZ3YRtZgDi/784mTF5u2VM0ySX22wjh64y9wenA1A/fgb80S2ooggi/LBja7R3c4A/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDcvMjAyMiAxNDoxMCwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPg0KPiBPbiA3LzE1
LzIyIDU6NTAgQU0sIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+PiBPbiAxNS8wNy8yMDIyIDA5OjE4
LCBKYW5lIE1hbGFsYW5lIHdyb3RlOg0KPj4+IE9uIDE0LzA3LzIwMjIgMDA6MjcsIEJvcmlzIE9z
dHJvdnNreSB3cm90ZToNCj4+Pj4+IMKgwqDCoMKgwqDCoCB4ZW5faHZtX3NtcF9pbml0KCk7DQo+
Pj4+PiDCoMKgwqDCoMKgwqAgV0FSTl9PTih4ZW5fY3B1aHBfc2V0dXAoeGVuX2NwdV91cF9wcmVw
YXJlX2h2bSwNCj4+Pj4+IHhlbl9jcHVfZGVhZF9odm0pKTsNCj4+Pj4+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni94ZW4vc3VzcGVuZF9odm0uYyBiL2FyY2gveDg2L3hlbi9zdXNwZW5kX2h2bS5jDQo+
Pj4+PiBpbmRleCA5ZDU0OGIwYzc3MmYuLmJlNjZlMDI3ZWYyOCAxMDA2NDQNCj4+Pj4+IC0tLSBh
L2FyY2gveDg2L3hlbi9zdXNwZW5kX2h2bS5jDQo+Pj4+PiArKysgYi9hcmNoL3g4Ni94ZW4vc3Vz
cGVuZF9odm0uYw0KPj4+Pj4gQEAgLTUsNiArNSw3IEBADQo+Pj4+PiDCoMKgICNpbmNsdWRlIDx4
ZW4vaHZtLmg+DQo+Pj4+PiDCoMKgICNpbmNsdWRlIDx4ZW4vZmVhdHVyZXMuaD4NCj4+Pj4+IMKg
wqAgI2luY2x1ZGUgPHhlbi9pbnRlcmZhY2UvZmVhdHVyZXMuaD4NCj4+Pj4+ICsjaW5jbHVkZSA8
eGVuL2V2ZW50cy5oPg0KPj4+Pj4gwqDCoCAjaW5jbHVkZSAieGVuLW9wcy5oIg0KPj4+Pj4gQEAg
LTE0LDYgKzE1LDIzIEBAIHZvaWQgeGVuX2h2bV9wb3N0X3N1c3BlbmQoaW50IHN1c3BlbmRfY2Fu
Y2VsbGVkKQ0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgeGVuX2h2bV9pbml0X3NoYXJlZF9p
bmZvKCk7DQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5fdmNwdV9yZXN0b3JlKCk7DQo+
Pj4+PiDCoMKgwqDCoMKgwqAgfQ0KPj4+Pj4gLcKgwqDCoCB4ZW5fc2V0dXBfY2FsbGJhY2tfdmVj
dG9yKCk7DQo+Pj4+PiArwqDCoMKgIGlmICh4ZW5fYWNrX3VwY2FsbCkgew0KPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIHVuc2lnbmVkIGludCBjcHU7DQo+Pj4+PiArDQo+Pj4+PiArwqDCoMKgwqDCoMKg
wqAgZm9yX2VhY2hfb25saW5lX2NwdShjcHUpIHsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHhlbl9odm1fZXZ0Y2huX3VwY2FsbF92ZWN0b3JfdCBvcCA9IHsNCj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAudmVjdG9yID0gSFlQRVJWSVNPUl9DQUxM
QkFDS19WRUNUT1IsDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLnZjcHUgPSBwZXJfY3B1KHhlbl92Y3B1X2lkLCBjcHUpLA0KPj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfTsNCj4+Pj4+ICsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJV
R19PTihIWVBFUlZJU09SX2h2bV9vcChIVk1PUF9zZXRfZXZ0Y2huX3VwY2FsbF92ZWN0b3IsDQo+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZv
cCkpOw0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogVHJpY2sgdG9vbHN0YWNrIHRv
IHRoaW5rIHdlIGFyZSBlbmxpZ2h0ZW5lZC4gKi8NCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmICghY3B1KQ0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVUdf
T04oeGVuX3NldF9jYWxsYmFja192aWEoMSkpOw0KPj4+PiBXaGF0IGFyZSB5b3UgdHJ5aW5nIHRv
IG1ha2UgdGhlIHRvb2xzdGFjayBhd2FyZSBvZj8gVGhhdCB3ZSBoYXZlICphKg0KPj4+PiBjYWxs
YmFjayAoZWl0aGVyIGdsb2JhbCBvciBwZXJjcHUpPw0KPj4+IFllcywgc3BlY2lmaWNhbGx5IGZv
ciB0aGUgY2hlY2sgaW4gbGlieGxfX2RvbWFpbl9wdmNvbnRyb2xfYXZhaWxhYmxlLg0KPj4gQW5k
IG90aGVycy4NCj4+DQo+PiBUaGlzIGlzIGFsbCBhIGdpYW50IGJvZGdlLCBidXQgYmFzaWNhbGx5
IGEgbG90IG9mIHRvb2xpbmcgdXNlcyB0aGUNCj4+IG5vbi16ZXJvLW5lc3Mgb2YgdGhlIENBTExC
QUNLX1ZJQSBwYXJhbSB0byBkZXRlcm1pbmUgd2hldGhlciB0aGUgVk0gaGFzDQo+PiBYZW4tYXdh
cmUgZHJpdmVycyBsb2FkZWQgb3Igbm90Lg0KPj4NCj4+IFRoZSB2YWx1ZSAxIGlzIGEgQ0FMTEJB
Q0tfVklBIHZhbHVlIHdoaWNoIGVuY29kZXMgR1NJIDEsIGFuZCB0aGUgb25seQ0KPj4gcmVhc29u
IHRoaXMgZG9lc24ndCBleHBsb2RlIGV2ZXJ5d2hlcmUgaXMgYmVjYXVzZSB0aGUNCj4+IGV2dGNo
bl91cGNhbGxfdmVjdG9yIHJlZ2lzdHJhdGlvbiB0YWtlcyBwcmlvcml0eSBvdmVyIEdTSSBkZWxp
dmVyeS4NCj4+DQo+PiBUaGlzIGlzIGRlY2FkZXMgb2YgdGVjaCBkZWJ0IHBpbGVkIG9uIHRvcCBv
ZiB0ZWNoIGRlYnQuDQo+DQo+DQo+IEZlZWxzIGxpa2UgaXQgKHNldHRpbmcgdGhlIGNhbGxiYWNr
IHBhcmFtZXRlcikgaXMgc29tZXRoaW5nIHRoYXQgdGhlDQo+IGh5cGVydmlzb3Igc2hvdWxkIGRv
IC0tLSBubyBuZWVkIHRvIGV4cG9zZSBndWVzdHMgdG8gdGhpcy4NCg0KU2Vuc2libGUgb3Igbm90
LCBpdCBpcyB0aGUgQUJJLg0KDQpMaW51eCBzdGlsbCBuZWVkcyB0byB3b3JrIChuaWNlbHkpIHdp
dGggb2xkZXIgWGVuJ3MgaW4gdGhlIHdvcmxkLCBhbmQgd2UNCmNhbid0IGp1c3QgcmV0cm9maXQg
YSBjaGFuZ2UgaW4gdGhlIGh5cGVydmlzb3Igd2hpY2ggc2F5cyAiYnR3LCB0aGlzIEFCSQ0Kd2Un
dmUganVzdCBjaGFuZ2VkIG5vdyBoYXMgYSBzaWRlIGVmZmVjdCBvZiBtb2RpZnlpbmcgYSBmaWVs
ZCB0aGF0IHlvdQ0KYWxzbyBsb2dpY2FsbHkgb3duIi4NCg0KfkFuZHJldw0K
