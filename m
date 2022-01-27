Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C061549E1BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbiA0L5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:57:14 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:48098 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbiA0L44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1643284616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RsbSncc9zqA3+HA9t+vJXMk8Qbdv5ay7NY7U/vhMb9I=;
  b=AYLzjjoLxvFtXaoMl/vAZkGn5jEMsqYtC0gsIsPc1S6Zqob03x3pRT9r
   P70FlvKp2d0E5sTpJtmPcyTsXGxiF9UdUKv8GrEb160E9HAdtdYDAVl9V
   8tBIP4TEThxTCbSgtCGtT5TdYzVjaof/W50xTGq40ugR3BSnOyh5Nl9wW
   c=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: iO5QUJOMUtv5x6T2zyiSMXKEPf+9hSy4FZxkMoX2/O5JWQhn4yZsPJMuf3oyf+Q5h98U4B1/9K
 O6bQ+rHAzf87f8NnkvwpwrK4LtzYZBWE2PXuy1tX2I+CGikjdtzYwg7UQn3b5mPMIkmhY/chJf
 qPbLB7H1WlHddJGMLid47Hb81MRe+UE9oKSAV+s5I7odzFG9h7tLzkSZGmyzb7i+yyu1ZP+/kv
 bntcLtSwuL1SL/OhEYbKnP4DXxKlb73IgB8HRWf5WkZkgBDivMAdsWf3jqdGBsR/4DKQfpipa7
 hVdst5265ClXCAS0JmRUs2nV
X-SBRS: 5.2
X-MesageID: 62885259
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:76cyF61K8EhA3Omz4Qw7aAqjBRZyeYIsimQD101hICG9Lfb2qy
 n+ppgmPEHP5Qr5AEtQ5OxpOMG7MBbhHQYc2/heAV7QZnibhILOFvAi0WKC+UyuJ8SazIBgPM
 hbAtFD4bHLfDtHZIPBkXOF+rUbsZm6GcKT9J/jJh5WJGkAAcAB0+46MHfhLqQffngdOXNTLu
 v52iMznUvHRZ1hVLXdOpBqZZmgm/T70LbdJTIWDR8u7weDyRmy7qThLhSe1hACFxtS3LYL6w
 H+4k/Ez5Tml8v+5g7X1mfV4ZgTssDm0MF/CMuFjdVQAinwizyveJ9qV9S5zXIISaCUmRMXee
 v30lAd1vdImjXsl6aO0ELQMjzboXITArnZuAelaDXY0JfErXkBerV8bMpiA2XkAgwbzYxBOe
 twrhKkX9A8N2KwoA3to9fPTB1kjUyyvD4rlvMSlWVWVc8EZKZWtpF3xjIeLH4sJlOz1GkcKp
 gkMCgc3ocjTXqKK3TC+mV/yt2lWXo+Wh+AX0gZo8SQlzxbhmpwwUcUzNEW2i5ozuNwd7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUKsHJ3XOoZjq56hd3pDmRLUYiJ8p3J
 jRWlJRsmA/P0roFM2VxZVOtgvARW2sNA6dg/22J6IJzIEUaICbQxFreWpe5PdI+c9vcfEzc8
 zDTa5rPw==
X-IronPort-AV: E=Sophos;i="5.88,320,1635220800"; 
   d="scan'208";a="62885259"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGYVkL2hN2xEiKgJdvImnmEFAtfkUtjl71I2PH3GaVmNx8QO6DCEWetnIFixJxv8ngVU+bL6bS+6cTqoNNlwHrFKEaK8Kg/Tr3By2qE9bwNlj8JhDVS3zHMSXrPlik5OrAVa+sHOioBgk1L28eiNVs8ddmg+ZmaccfoQbyyEvrXIMI8lMc6Y2tmhcSHqc4NtXBuyBzekKupD/n6kUqtsL5KHr+u7YUzXdRKb6Zj3OzEwhh0s59rnCI2MT6vXkwjfxi9C0sTWdm2Bm6D3dz6Zt470YD6ZyaxxN6/q79jCUJo5zY/PDenfcjBIwsVW4ZGHILO6mK3DYmIh94ozDiuGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsbSncc9zqA3+HA9t+vJXMk8Qbdv5ay7NY7U/vhMb9I=;
 b=QJA4Fd9EfZ+WudlR0bJSdZN+P1bYHE5a20YNCTNJ4EzewpPVLYXSm0MoDAg+VkFJ/ml9/aNS44UeOR9IkHS7uQaIKwP6YOt5zFxVdXbweFikb+TrcvNsLcT9HIw/Q1+H8yZnIQEFTg0rUrSsXEW6Onm8LkwSQjdKMGBF/sfd4M78SHMi+AW7rLAhEm5Z+79Itz/jitt2nMMs/rsQJw8E9rV73j84UYR4maUUP2GVpDdIXUnPVVMfXgJ/C/Rv8PnXXDlkhE4bXYEISot2+bmiNwVo6ElReGG8+ej7USxtSuw8bXl71tjY+mSRW3O4hJ4CtMkWkkZcnjhdlNi02dxsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsbSncc9zqA3+HA9t+vJXMk8Qbdv5ay7NY7U/vhMb9I=;
 b=d53NklllhEtrkO86ch4ANcRycmker63ozRSOui5iJGSqpHoLajWl3ikZXwWG0Arzx3Iwi02RPaWxp0u1j8W2jQOd4mtHwLYPtBsjuBBhu/08cXKNVlPPI1ofZYYMQ/uq9rWfB3nntaUXP7UCQayeOt7CKdp+hF9o5nbined/qX8=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Kyle Huey <me@kylehuey.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Thread-Topic: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Thread-Index: AQHYExD1HG4KmrLRmkWVrC55RIbhw6x2I0wAgACZXwCAAAchgA==
Date:   Thu, 27 Jan 2022 11:56:50 +0000
Message-ID: <d5d939f3-6f96-a003-44d1-547d44dfa9b9@citrix.com>
References: <20220122072644.92292-1-khuey@kylehuey.com>
 <878929bb-39e7-f1b1-a6a2-f6057517058f@citrix.com>
 <YfKChjX61OW4CkYm@hirez.programming.kicks-ass.net>
In-Reply-To: <YfKChjX61OW4CkYm@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efcb5483-91fb-486d-1115-08d9e18c1a44
x-ms-traffictypediagnostic: BL1PR03MB5958:EE_
x-microsoft-antispam-prvs: <BL1PR03MB5958BF53A4BE94956E33843EBA219@BL1PR03MB5958.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qe7F5HbKYKNeAoQs6Uk/Z98iox4aK5VEoer1KeTjgwBHXYhsaj0HnXNE83KRPUSeRWtTh9u/8wkvVgHm92uenh52X5p/G9US+g1m+OQOFjTRmFG30spbKY+AquC2oulf+f6AL7UmT8F1x71dPryESAAwy7uBv+2U4bF9mWJznpfSy0DSMH3D7t++15JNCFJ6fzHGlPRD9OWgpuI0mnXsdVfz33h84IrcmIxFKBvSWQvI/aAZ6av7OhYwP+EYIrDmOueOSfX+DgA+AIy12Ntu0ycJb2Bj2RaFi30xIl+MWjCPNYDgSOO/fmvkDNRWVrgZBmVMqhcuzmZonVKLj32zeEfciCCQLbNssF1BPTSjWHBPRnxCMzzSBa3FFDaLOuAr2JQtGGqZ1zWnqY8HZFICUu30dmBUGmShSnqdylnndh8Fyn/SIIL6FCTCVlSbNRH8F/yhxdkkuI4bmqZ2PmMkt3sZgQLO2re0iNN0VnvXA4Zc+CncbhbtNV59r2rJjoIgo349rro9u3SsmqgPbWWKWCFdr7Ab5phjHVBgcvxfXXIwEu9vAYmGrgOesWJcfh7GIM/aFu5WOILKVpkGfhw0WIHWRwOF4lmsv7pAiGJHGKjnFOHr7RvuM2BPZRf/F3PctfgY3bUuCrbdT0aBf2ezjKRwT/SMB1Pjjt3GRle95ylyQCN8buPuTNJxGfkb/adyUcRnJGzmloGIUbiWW0weAc+THRirBGwlz1NKqdAbbYMVyiI+bmCyOqqP/v/KO+o4MR5LMbxUmHYTPpFABGClUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66446008)(64756008)(66946007)(91956017)(76116006)(2906002)(83380400001)(54906003)(6916009)(316002)(8936002)(31696002)(508600001)(6486002)(86362001)(36756003)(2616005)(186003)(8676002)(5660300002)(7416002)(53546011)(122000001)(107886003)(26005)(31686004)(71200400001)(82960400001)(38070700005)(38100700002)(4326008)(6512007)(6506007)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUI3MkpiYjFTdmpybFFaRTNnMnJzVW41cFdxMk9lckQ0NnpjdzZWcGFPQ2Zq?=
 =?utf-8?B?YW5tWFhoTXhVbUd6TWFQTzhEVmdodG8zRG53dFpGYVhSbzIxZ2xNNHpDYUdH?=
 =?utf-8?B?VSt0NVpTdGlsRW1HQ0RGYVlncThlWUw2LzRuK0NLVXYxK1hyQnRSUGE4WU1L?=
 =?utf-8?B?aFRaL3dUeXMwanFsUXdHTE55YXlKUWxIYVVWQkx6bTFyWE9CSWptN2dwMkJM?=
 =?utf-8?B?Qm9zUzNWY0R4aTlMRFAxWFBGZ1ZBeXlTQW5FMlI4ekdWc3phNFVTMzlUbU5q?=
 =?utf-8?B?SFBaTDlsd1hYRXJsSDhWaVBBM0poZXJaWERqc0NnWFNDYmZRcktCSTNWWDI3?=
 =?utf-8?B?S0FKOVhTK1BtNnFXclc2OEF6cWtBMmljdXNWdHE4UEtSOXhBYkxMRjJwVFpL?=
 =?utf-8?B?SWdoRDJwUmJmT2JvejczcGZqMVpPZ2pDL1RsalpzdFFpTTVFUk81SW92RjVD?=
 =?utf-8?B?Zk12Tis5aWVNc1pSamlsY25JcFBjM1JEcE5VU3A3YTlJWHdycS9vOUZOM0Qy?=
 =?utf-8?B?dC9qM3JIV283dmZoYVU0TS9tcUdBeVlXd3VMN0J4KzFIc2RXa2M0bitLdVo4?=
 =?utf-8?B?QkRhRER6VU80Vm00QkdZMXpHbkdyMzJ4UjI3a3BsMTJCZy9LUnJKdWs5S1dS?=
 =?utf-8?B?aThXT3dCYUQ0NndReUtVb051N0Z6M0ZDZ05NNHBCdjc4QWw3ZXdnMFpFRHJ4?=
 =?utf-8?B?ZTVKNEdOR3E1Sit5d1ovSnpvc3VkblBhQVMrVUR1ZTJVVTBaNUpYS3N6MERx?=
 =?utf-8?B?THg3NEwxUENjVWtuT0szYy9RazVBaUdrNGhKTTdESlNrbzVjMmNrNHRWcDR0?=
 =?utf-8?B?M1dsVStFUlNaTlAwNEJHZmYyNUZBRVVvSVZ5ak5mSHdrMVVjWVBNVURWU2Jt?=
 =?utf-8?B?ZUdZaXFPTzIrNmNMdk5OTFdMZzYwVVFUWHg3YVpVc0FycDdFcVZ6TE8xTlBN?=
 =?utf-8?B?Z2xpZmdLQkJraGg3TnBGazVSZllRaUVTL2lXT0laVE9XaExMTXk0SzFQSUNY?=
 =?utf-8?B?aEpyaHV3MTA2ajk1RDBRby9FNXNKVDM0VU9MbHJaWG1ZSktlOThORUVQaDJn?=
 =?utf-8?B?MmVYUTJLUkZFTDh6L0svMUhlKzRWVTRiVDV5MHdkSGU2YlVBWmRlM3J2UkR2?=
 =?utf-8?B?Q2JvTnVKQU1OMzJHV1FYRlFKOEFwdU8yUWJtcjBrS3VLbjJUcU5JSFRRVC9r?=
 =?utf-8?B?Q0hNenNIcitaekZHSUJkaUR0ZVJWSUhXTFoyb0tSajZidGdNd0NZOVlHTzlj?=
 =?utf-8?B?U3BnR3FCZWJ6TGlxSjBaT3ZvamtXYmdSVVhIb1FCM2RPUnJPL21zQXQyM3lr?=
 =?utf-8?B?ZmtiR1daRVVrV1gxYzZnRHZ0Z3VUM0ZxdXd3UTBUb2hnUTdubnpKSW1IUkZN?=
 =?utf-8?B?NWZBNjZyNmdWMFp3b1FpdFhUdkFQdTdnUm9oWjViTEp4ektDak1GMFgxSW9B?=
 =?utf-8?B?NjBKbm5kSVdyRDNwSmRkU3BmdjN3SUg4N05RdUNYTXlKaXFJbXU2WEtrN1NO?=
 =?utf-8?B?ZzZSK2h6ak9VRDFnL0FuUUhEV3Z3MHh4d2RIdzFNOW4xSkRQS0lhUGxxaElI?=
 =?utf-8?B?VlhRcDh2WDJNVjhOTmdKODc0N1ZqOUlabnJONzJBY213TFlNN3QxbTRFN3pU?=
 =?utf-8?B?N3FoMVVGYWZrNkFJbTU5d1NoSWlqb25EYmNxWjU4VmE2bnZNTVM4Qy9mSEh3?=
 =?utf-8?B?MGlEbVA4M2dJREVsNVhPYmlWb3FuNDJScHpicVBrbXR2N25qQzVPenlZNUhj?=
 =?utf-8?B?YjJxOUFFMU1icFBMQUZWSTVLalVWczlkcS80QmJLdDlVTXJ4bTFTYVpnRHBw?=
 =?utf-8?B?WSs0eEVPQm5aVjdxdFhWVDJFYlhwMU42Y01tTUdTSGFpbEdrMHUyU0tkcFZo?=
 =?utf-8?B?KzBScnlzM3Q0bFZtZHlSUzJBSVBTZVJuTldkTDFzaWhGbG00eWNsVWJZbE5i?=
 =?utf-8?B?MDlicVV2M0JRa3RwNUJCTzJObk1rS3gxTmsxOWRiVWJTaGFUbEYwYnVWWDRa?=
 =?utf-8?B?TWZsUk5mclkra0tmVWhGVkhlNWhDVkIveVk1Ymt1REpzcGVJbUZrcEMzTHJF?=
 =?utf-8?B?NnVTU0wraTdVSXFNZXY2NjdtaEgybnhGWEVPc3RMeFFFZ3VBdWhRek9DZm5P?=
 =?utf-8?B?QlQvdk5oWnR1U1VQTGdxYnVScUJBUGZNRDE5R2NDZGJMSkgyTjB5T3ovdHRv?=
 =?utf-8?B?ak5Zak9JZVEzQjZ3WmhWa1hZUlo3eWY0WGdHVnZjQ3kzZC9BczFXZXhSU29o?=
 =?utf-8?B?a083amdSNTkxeG9zcDliRzZwV253PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF1CE1204827C646A837AB17811D6A1F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcb5483-91fb-486d-1115-08d9e18c1a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 11:56:50.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ybVYuLdy0tDbobqPHIz0sWKB4Oh/u0EkpP6NdkU6f7IxieTuFdz7t1XGJIqZzdYnq07h9yYzPf7Gz+JEDV9RBJsPmrCEjStvLlPSu9vWOWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB5958
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDEvMjAyMiAxMTozMSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIFRodSwgSmFu
IDI3LCAyMDIyIGF0IDAyOjIyOjIzQU0gKzAwMDAsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+DQo+
PiBGcmFua2x5LCBpdCBpcyBhbiBlcnJvciB0aGF0IEZSRUVaRV9XSElMRV9TTU0gaXMgdW5kZXIg
dGhlIGtlcm5lbHMNCj4+IGNvbnRyb2wsIGFuZCBub3QgU01NJ3MgY29udHJvbC7CoCBBZnRlciBh
bGwsIGl0J3MgU01NIGhhbmRsaW5nIGFsbCB0aGUNCj4+IFVFRkkgc2VjcmV0cy9ldGMuDQo+Pg0K
Pj4gTGludXggb3VnaHQgdG8gc2V0IEZSRUVaRV9XSElMRV9TTU0gdW5pbGF0ZXJhbGx5LCBiZWNh
dXNlIG1vc3Qga2VybmVsDQo+PiBwcm9maWxpbmcgcHJvYmFibHkgd29uJ3Qgd2FudCBpbnRlcmZl
cmVuY2UgZnJvbSBTTU0uwqAgUm9vdCBjYW4gYWx3YXlzDQo+PiBkaXNhYmxlIEZSRUVaRV9XSElM
RV9TTU0gaWYgcHJvZmlsaW5nIGlzIHJlYWxseSB3YW50ZWQuDQo+Pg0KPj4gSSdtIG5vdCBzdXJl
IGlmIGFueXRoaW5nIGNhbiBiZSBkb25lIG9uIHByZS1GUkVFWkVfV0hJTEVfU01NIENQVXMuwqAg
Tm9yDQo+PiBBTUQgQ1BVcyB3aGljaCBhcmUgYWxzbyBnYWluaW5nIENQTDMgU01NIGxvZ2ljLCBh
bmQgZG9uJ3QgYXBwZWFyIHRvIGhhdmUNCj4+IGFueSBlcXVpdmFsZW50IGZ1bmN0aW9uYWxpdHku
DQo+IFdoaWNoIHN1Z2dlc3RzIHNvbWV0aGluZyBsaWtlIHRoaXM/DQo+DQo+IC0tLQ0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYyBiL2FyY2gveDg2L2V2ZW50cy9p
bnRlbC9jb3JlLmMNCj4gaW5kZXggYzkxNDM0MDU2YzI5Li41ODc0ZmEwODg2MzAgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3JlLmMNCj4gKysrIGIvYXJjaC94ODYvZXZl
bnRzL2ludGVsL2NvcmUuYw0KPiBAQCAtNDcwMyw2ICs0NzAzLDE5IEBAIHN0YXRpYyBfX2luaXRj
b25zdCBjb25zdCBzdHJ1Y3QgeDg2X3BtdSBpbnRlbF9wbXUgPSB7DQo+ICAJLmxicl9yZWFkCQk9
IGludGVsX3BtdV9sYnJfcmVhZF82NCwNCj4gIAkubGJyX3NhdmUJCT0gaW50ZWxfcG11X2xicl9z
YXZlLA0KPiAgCS5sYnJfcmVzdG9yZQkJPSBpbnRlbF9wbXVfbGJyX3Jlc3RvcmUsDQo+ICsNCj4g
KwkvKg0KPiArCSAqIFNNTSBoYXMgYWNjZXNzIHRvIGFsbCA0IHJpbmdzIGFuZCB3aGlsZSB0cmFk
aXRpb25hbGx5IFNNTSBjb2RlIG9ubHkNCj4gKwkgKiByYW4gaW4gQ1BMMCwgbmV3ZXIgZmlybXdh
cmUgaXMgc3RhcnRpbmcgdG8gbWFrZSB1c2Ugb2YgQ1BMMyBpbiBTTU0uDQoNCiIyMDIxLWVyYSBm
aXJtd2FyZSIgPw0KDQo+ICsJICoNCj4gKwkgKiBTaW5jZSB0aGUgRVZFTlRTRUwue1VTUixPU30g
Q1BMIGZpbHRlcmluZyBtYWtlcyBubyBkaXN0aW5jdGlvbg0KPiArCSAqIGJldHdlZW4gU01NIG9y
IG5vdCwgdGhpcyByZXN1bHRzIGluIHdoYXQgc2hvdWxkIGJlIHB1cmUgdXNlcnNwYWNlDQo+ICsJ
ICogY291bnRlcnMgaW5jbHVkaW5nIFNNTSBkYXRhLg0KPiArCSAqDQo+ICsJICogVGhpcyBpcyBh
IGNsZWFyIHByaXZpbGVnZSBpc3N1ZSwgdGhlcmVmb3JlIGdsb2JhbGx5IGRpc2FibGUNCj4gKwkg
KiBjb3VudGluZyBTTU0gYnkgZGVmYXVsdC4NCj4gKwkgKi8NCj4gKwkuYXR0cl9mcmVlemVfb25f
c21pCT0gMSwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBfX2luaXQgdm9pZCBpbnRlbF9jbG92ZXJ0
b3duX3F1aXJrKHZvaWQpDQoNCkknZCBzYXkgc28sIHllcy4NCg0KRWxzZXdoZXJlIG9uIHRoaXMg
dGhyZWFkLCB0aGVyZSBoYXMgYmVlbiBjbGFpbXMgb2YgImV2ZXJ5b25lIGxpa2Ugc2VlaW5nDQpT
TU0gc2FtcGxlcyIgYXMgYW4gYXJndW1lbnQgZm9yIHRoZSBjdXJyZW50IGRlZmF1bHQsIGJ1dCBJ
IGRvbid0IGJ1eSB0aGlzLg0KDQpOTUlzIGFyZSBibG9ja2VkIGluIFNNTSwgc28gUE1JcyB3aWxs
IGJlIGF0dHJpYnV0ZWQgdG8gYW4gYXJiaXRyYXJ5DQp3cm9uZyBpbnN0cnVjdGlvbiBib3VuZGFy
eSwgYW5kIHRoZSBlbnRpcmUgU01NIEhhbmRsZXIncyB3b3J0aCBvZg0KY291bnRlciBjaGFuZ2Vz
IHdpbGwgZGlzYXBwZWFyIGludG8gdGhpbiBhaXIsIGFwcGVhcmluZyBhcyBvdmVyLWNvdW50aW5n
DQphcyBmYXIgYXMgdGhlIHByb2ZpbGluZyB0YXJnZXQgaXMgY29uY2VybmVkLg0KDQpXaGVuIGl0
IGNvbWVzIHRvIFNNSXMsIHRoZSB0d28gaW50ZXJlc3RpbmcgY2FzZXMgYXJlOg0KMSkgQW0gSSBk
ZXRlcm1pbmlzdGljYWxseSB0cmlnZ2VyaW5nIFNNSXMgd2hlbiBJIG91Z2h0bid0IHRvIGJlLCBh
bmQNCjIpIElmIEkgZGlkIHJhY2Ugd2l0aCBhbiBTTUksIHNob3VsZCBJIGRpc2NhcmQgZXZlcnl0
aGluZyBhbmQgc3RhcnQgYWdhaW4uDQoNCkJvdGggcmVxdWlyZSBwYXlpbmcgYXR0ZW50aW9uIHRv
IE1TUl9TTUlfQ09VTlQsIGV2ZW4gaWYgdGhlIGFuc3dlciB0byAyKQ0KaXMgcHJvYmFibHkgbm90
IHdoZW4gZnJlZXplX29uX3NtaSBpcyBhY3RpdmUuDQoNCn5BbmRyZXcNCg==
