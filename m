Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FA94B5A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiBNTms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:42:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBNTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:42:44 -0500
X-Greylist: delayed 3431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 11:42:25 PST
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25392E0AE;
        Mon, 14 Feb 2022 11:42:25 -0800 (PST)
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1D228C0884;
        Mon, 14 Feb 2022 18:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1644864280; bh=s2TNu6IFLpEE0kCsHtKwe5q6d5xS2iKbOyOmY2nUZWw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fP7HDGhJ7+29eB9OI6dHg0znUNLLcLgHQdIabP4ujmo6uCG9s491ClOOLgtbsSsP2
         FDh7ggxwSE5jCD+Z9Dq/eow+YepSvj96oAlGHjEc7+yLMufTU+crvfpPEkZg8unUIB
         1nuFcEVzgLRad2TIx8DXTk1SCRJzQCKEu+EhUhFjaqQ3JYtlYMGiuZvXtHRwjU8GWi
         dm9vyaonzMp7W0eQTRz56/0rExqa0HXyD9ZWPpsun+eoPZOPdJ7GPqY53MhRT4GSWI
         VgnQdHJbnKCME+Ir/p793Fgg9fjGBmvcwhH16ecnQz3N6yQ3OH+mSCV8pR2zCyx4HO
         gIPeh4XANy9VQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 241D4A009C;
        Mon, 14 Feb 2022 18:44:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 612868014D;
        Mon, 14 Feb 2022 18:44:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="HYYhSjif";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIdpFGPqPUjgsON3orqhz9/KADn9wWKCw7pzDU7nBro7RstsDq1f/mLjzkfR+pZeLv5RW75BWwgPneP8PZ7M0ajlFEwOuJyB9VetSlB20I3Z3TTlvxlJz31AMLiO2JwFJh8pUZB9Y5FhdjLzAxe/ISCzTPM4nDd+HZGqjdeJ/iVu/GV5mEmzgcZio+5VBEEtY/WvTjnT3WMMXCD/gaTt1xwzEgok3Sy7MbdatYGictxLWNU/RwG0YrzSLW7g5CoZqso06BD5SSiBEq+ecG5FYJ0wihfLg6EckoFj2nWzsDmz5Dc75m/jhg+BNPBY0vusdcnF8gg2EQ3mOgj0YPWCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2TNu6IFLpEE0kCsHtKwe5q6d5xS2iKbOyOmY2nUZWw=;
 b=AdUHsdUb31SEO33NukWVriVElM29ur5QQ/ShZ8btVJTEhQtZW4+LXmhG0IhEs5BQEE1ai4NP1N0R0O5tVC7cS+WGUDF1jnJCur8ImSniccrfxir8v7pqdZyWMGKppbMYvrU6teoYX/umRiyZtFVZj6ly+BqqcWdcdykC5dMD/xO39fMuic9MpLN6BskPL/owgxP4aJSZqzflCrOm4o3zfu/mlmRPd1QAe9/m/kBGr2k0YZnCYdvt+7stbMqXP6SY9LVkkN4hwrRHJuSEUgb3p9RYNcMgdr2A/AtPLYhXhQPHWC7WmtUMRF63fyhCFhKPadcJYd78I5OzTNGuEl+Cfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2TNu6IFLpEE0kCsHtKwe5q6d5xS2iKbOyOmY2nUZWw=;
 b=HYYhSjifv43d+adc+LQ/OHTIeBhmE1OCBx0fg9T1TWx/B0R4dbXOmrPrI+HPqMTmpfHS+LVDx3ixmDyUxttkd2n5wa0QmxWO2xnNY4fIaU46Ocl+w6o9j1N41ICvEfN/CEk9b7hn8Nmqzf7S4XbhH390dq65rhx6dS0HfSfKYY0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY4PR12MB1590.namprd12.prod.outlook.com (2603:10b6:910:a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 18:44:34 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4975.017; Mon, 14 Feb 2022
 18:44:34 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in
 ep cmd fails
Thread-Topic: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Thread-Index: AQHYIZOvXlHACGixbUGMAnHCl5PyK6yTYqcA
Date:   Mon, 14 Feb 2022 18:44:33 +0000
Message-ID: <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
In-Reply-To: <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4af71e8d-d64c-48ac-e48b-08d9efea0b8a
x-ms-traffictypediagnostic: CY4PR12MB1590:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1590D79AFF908B6FD5F4552DAA339@CY4PR12MB1590.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GB1/JMLkCqodp8prTZ16gdCYr06Rn1rukEeW9JfyDj3zDYfw7eEFLUXtpbsGFVwDJLUwiDoDdU4iAWA+SVLI1CNAONOQ+YJEvoQovJhp16oB3WPPX1lKr32oLJMFCuSduExRXFPJdY3vSwAszfmVmSNd9GJ3T4VSLvuxBZnMyqYCox4DYz/QuAt+8OZP3+x/qHqCC4sJaAU98jko4niiN67Df/JZq7b5z8XecCTOkgu7GLaJ6FFmzhAjrZUdJwfcjYFxQWIfmQtZ4gnSuwdQ9MrvDtmNO9n37hbt/MYLAAH7LJERo4WmC5pKRsj6lheHxxzOB4f2C+2TuQBbS5o6tOO7awJZcjbbvPPKCcg2z0LeFgGCQ2Ul5BaPUFlBLw7JEO5VH81hPRQGtluS1dEMj5WyDCTJ8yVsBVTwusRse15Ox1aLJWMWyOQLK3XMXg2NEstBzjluSg6TVQ0kfyIZRmCrR3yELeWBgMSkr+1FkAJMm131pRBq9v2TbuMn0FaQA0o849iPcKNYbulpwhEC0wMQkeDERIhce2PrzqjvOJYqB5j7sZ+OncP3WJTV3ArgsRjlPishmLHJI6MHO5IS23B07ppwECSPxWJZ5MSSOmokJ8zCwyZsarr0U/cXypuIKY/jbIRc3fCJVzqZhg2omr4MnFVVc8tiArGWFR/qu3PV70W4uom0sg8WneSeA2YY74sO9YQ5l+PII6WynDndeZVl0f7EAuSXvamL5BEAnjyT9BNMCaYMNHIpPW93R5jqtNM6suQVarAsabsT7LmVVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(4326008)(186003)(31696002)(66946007)(66556008)(66476007)(8936002)(2906002)(5660300002)(38070700005)(66446008)(76116006)(86362001)(36756003)(122000001)(38100700002)(8676002)(71200400001)(83380400001)(2616005)(6512007)(107886003)(26005)(31686004)(508600001)(6486002)(110136005)(54906003)(316002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elI5cVlhQUV4TE1CU2lBSlRCUHVTUVZCU1oxRFBqUzZJUE9Kcy94d0lLdkNV?=
 =?utf-8?B?eWVjbTVCdHNxREVmWTZYVHdoU045ZHJJRDZuUmUzZzF5dUQzYXU5SlhKNk53?=
 =?utf-8?B?SlQxVXI1cTJRdHBsb2toWW90UGFPSW93YlFKTi8vZHZOMTZXdlBZcFpja3Bi?=
 =?utf-8?B?dnB0NEhjeE9NN1NRalB5YjhQMlB6dlNRcXZBTkQwcSttcXhXNC9PY3h6dzZK?=
 =?utf-8?B?S09FMXF3aUhUVXJpd1V1aGlKdDhwZjltS25VdkJUbjk2VHBKbW5LVzdpM1Z4?=
 =?utf-8?B?MEpZaGo4L2tnY2NMTU9sQitpWVVsMmFjUjZjZW5aMnF2Sm93UUFtSys3MTVF?=
 =?utf-8?B?MitFWFY5TFBUT2hzdTBLQmErbnFQN0pkSW5iaXZJTkYxM2pqMUY1d2FvYTdR?=
 =?utf-8?B?T3EzdTN6SXRha1VPOWZSKzcxcmdFZUloQ212akRvNHNhTUs3SzVsZHhrbVha?=
 =?utf-8?B?K25zdHNKYy9xZHpyN1BsRGFOeTZWa0QwdHF3dDRWSUhFbzByRFZSRnozVXdw?=
 =?utf-8?B?a1lGTHpWUGxva1V6aDE2ODNyZ0pTbjZRZTEvOUN2VllUMFpNUGNKdlpZTDJ2?=
 =?utf-8?B?Vm1PaWNLU1R0UThJTkpiZ1NaR3gzS2JhWXRXblBJb0lxOFNLc0tZUHFaWHQ3?=
 =?utf-8?B?bEQ0bGE4b29Tb2ZGV0Z6cDJYUkRGUXJ4RzVjVHZiN3ptSHVMNHpRbGkya1VX?=
 =?utf-8?B?UnRZTGJ2aGJzSk4xc0RXN1ZVaEwyakxQTGVrOU1IdWFCRk9HeCtQc3Z5cmpV?=
 =?utf-8?B?ekJrcWVuTCt5WmR5WTcrSGhJTU1SMjNUVnJ0TFZ5U0owSVUvVEhuQlNUYnZw?=
 =?utf-8?B?QUQ0aTJaaFRnTjZEdmxrK1pWdVBPTUE5eU50RHlVVE9ac3EycFRTUEVubHFn?=
 =?utf-8?B?NE5uMmFvajZrbGF4c3Z0dUJWV0ZRNUtmMVl3Yyt3REE5VGh1NFdGYWFDZCt4?=
 =?utf-8?B?d2YrMTRIclJnQUZrWmlPR1ZvSGVZdDBRdFphdmxKSkRWendUb0taZDRYRnFR?=
 =?utf-8?B?TkZDeEdQbTFoWDhnYmVQN3A3ZHlPc2RNRDZHNk00THJab2VMZ3lKbERxOGNi?=
 =?utf-8?B?Y0d0Sk51UkNnU2dyWGgwWWR5Q24xNDNpVGpUZkYxYk1RMTFBeHQrNmFlYisv?=
 =?utf-8?B?dTk0SWRrRyt4b0x5R3RJb2RIbTF6YlgyS1BYTGZjM3JPRFZQakY2V1BESHFB?=
 =?utf-8?B?L3FOamxISFVNS28wcVRkeW9OeG5jOFUwNDIyN0dpMGZmMm1OeGpqa3dCY3Fm?=
 =?utf-8?B?cUZCelU1WHVLZjdSOStZL2xWcG83RG1UQmx6OWNjTUxJWEZlSGdBMkVoeGwr?=
 =?utf-8?B?ZUt4K0duUU8xUk9MbzlUYVZiRklIWVRiNXBoNTNEU2V5QmRFcUREVmcwSFE2?=
 =?utf-8?B?NWdUUkRUTDFFNmowTGx2VUxYZXY0bEJtTlJMQjZoSDI3ajBnSGQyazJhdkFG?=
 =?utf-8?B?OHI4MnZTdGdzRXFCYzhKWmJ4SVVFb2I4MGZDVGlVNU50TTFwUnBrbFIvakxU?=
 =?utf-8?B?bjJMWEdIbmdqb0xnaDJ0SHJlSVE2bGx5VVRmMjlxZ2MyNnVSRldQcmVZbGYw?=
 =?utf-8?B?aHhySEE0Zm5lTENKWG5vR0lQVE1jM3hSQ1lkUFIzazNRTGFBZFFyZVdqT2gr?=
 =?utf-8?B?WnZZQndGYWdoOVpOMXcyb21yNzViMVcyM0xVcUZoUnpvNU1saEx3QjVZUTg5?=
 =?utf-8?B?c2NHTDJnaTZKWlJFbHRUdXIvamVyMGpPUjZnSTNwR2k2R2xDamlPVy85ZE9B?=
 =?utf-8?B?RWFweXlBeUg5K1E4RHFQZTh2NEllV3RxRUxOOURpY2tDaERJSUtBZHZlUFRG?=
 =?utf-8?B?QmpiL2cvVlI4WHBQcHdOTjBaRWNiYU1WME51aWNmY3FZd1VHdXd4OCsycHNL?=
 =?utf-8?B?Zm9jcWFSaksySlBpWE9jUHp1S1NOb0VKNkVQUEs5OFNOL3RlM0RINnJabmxO?=
 =?utf-8?B?RWJUelJNN0QzUVhMVzd2OEpOZGlZc1ptKzE2d0xVNnNaVW96anFRNkxPdHA0?=
 =?utf-8?B?TnVXZHdWdFZ6aFBhMk5aTlVUa2gvQ0F0Z1c3djYxUG5QRGNnUyt1cGt2S0R1?=
 =?utf-8?B?clB5UE9KckNiUHZ0WVpHRE1xOVY5eVNlMmVkdW5QZ3IySDRtRi8rWURlYTNv?=
 =?utf-8?B?MmhycTdpc01DZTY1eDdJK0NtTW9BbXN1UitRU0VTdGJnc05tdnRReUQ2bnZv?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D32B78B9EB80594A8D8D8E681821249D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af71e8d-d64c-48ac-e48b-08d9efea0b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 18:44:33.4205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1B9TkjaCbFUjfZ2c//4LK/Cz2ZcQzm+oUTI+SG3UdafgFwauHWJSFWvJMHJGuA+t3jIghLKOSgVLjIwziJY0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkRhZWh3YW4gSnVuZyB3cm90ZToNCj4gSXQgYWx3YXlzIHNldHMgRFdDM19FUF9FTkRf
VFJBTlNGRVJfUEVORElORyBpbiBkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyDQo+IGV2ZW4gaWYg
ZHdjM19zZW5kX2dhZGdldF9lcF9jbWQgZmFpbHMuIEl0IGNhbiBjYXVzZSBzb21lIHByb2JsZW1z
IGxpa2UNCg0KSG93IGRvZXMgaXQgZmFpbD8gVGltZWQgb3V0Pw0KDQo+IHNraXBwaW5nIGNsZWFy
IHN0YWxsIGNvbW1tYW5kIG9yIGdpdmViYWNrIGZyb20gZGVxdWV1ZS4gV2UgZml4IHRvIHNldCBp
dA0KPiBvbmx5IHdoZW4gZXAgY21kIHN1Y2Nlc3MuIEFkZGl0aW9uYWxseSwgV2UgY2xlYXIgRFdD
M19FUF9UUkFOU0ZFUl9TVEFSVEVEDQo+IGZvciBuZXh0IHRyYiB0byBzdGFydCB0cmFuc2ZlciBu
b3QgdXBkYXRlIHRyYW5zZmVyLg0KDQpXZSBzaG91bGRuJ3QgZG8gdGhpcy4gVGhpbmdzIHdpbGwg
YmUgb3V0IG9mIHN5bmMuIEl0IG1heSB3b3JrIGZvciAxDQpzY2VuYXJpbywgYnV0IGl0IHdvbid0
IHdvcmsgZm9yIG90aGVycy4NCg0KUGxlYXNlIGhlbHAgbWUgdW5kZXJzdGFuZCBhIGZldyB0aGlu
Z3M6DQoNCjEpIFdoYXQgaXMgdGhlIHNjZW5hcmlvIHRoYXQgdHJpZ2dlcnMgdGhpcz8gSXMgaXQg
cmFuZG9tPw0KDQoyKSBBcmUgdGhlcmUgb3RoZXIgdHJhZmZpY3MgcGVuZGluZyB3aGlsZSBpc3N1
aW5nIHRoZSBFbmQgVHJhbnNmZXINCmNvbW1hbmQ/IElmIHNvLCB3aGF0IHRyYW5zZmVyIHR5cGUo
cyk/DQoNCjMpIEhhdmUgeW91IHRyaWVkIGluY3JlYXNpbmcgdGhlIHRpbWVvdXQ/DQoNCkJSLA0K
VGhpbmgNCg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYWVod2FuIEp1bmcgPGRoMTAuanVuZ0Bz
YW1zdW5nLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgOCArKysr
KysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDE4M2I5MDkyM2Y1MS4uM2FkM2JjNTgxM2NhIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTIwNDQsNiArMjA0NCwxMiBAQCBzdGF0aWMgaW50IGR3YzNf
Z2FkZ2V0X2VwX2RlcXVldWUoc3RydWN0IHVzYl9lcCAqZXAsDQo+ICAJCQkJZHdjM19nYWRnZXRf
bW92ZV9jYW5jZWxsZWRfcmVxdWVzdChyLA0KPiAgCQkJCQkJRFdDM19SRVFVRVNUX1NUQVRVU19E
RVFVRVVFRCk7DQo+ICANCj4gKwkJCS8qIElmIGVwIGNtZCBmYWlscywgdGhlbiBmb3JjZSB0byBn
aXZlYmFjayBjYW5jZWxsZWQgcmVxdWVzdHMgaGVyZSAqLw0KPiArCQkJaWYgKCEoZGVwLT5mbGFn
cyAmIERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcpKSB7DQo+ICsJCQkJZGVwLT5mbGFncyAm
PSB+RFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEOw0KPiArCQkJCWR3YzNfZ2FkZ2V0X2VwX2NsZWFu
dXBfY2FuY2VsbGVkX3JlcXVlc3RzKGRlcCk7DQo+ICsJCQl9DQo+ICsNCj4gIAkJCWRlcC0+Zmxh
Z3MgJj0gfkRXQzNfRVBfV0FJVF9UUkFOU0ZFUl9DT01QTEVURTsNCj4gIA0KPiAgCQkJZ290byBv
dXQ7DQo+IEBAIC0zNjQ1LDcgKzM2NTEsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX3N0b3BfYWN0aXZl
X3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwICpkZXAsIGJvb2wgZm9yY2UsDQo+ICANCj4gIAlpZiAo
IWludGVycnVwdCkNCj4gIAkJZGVwLT5mbGFncyAmPSB+RFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVE
Ow0KPiAtCWVsc2UNCj4gKwllbHNlIGlmICghcmV0KQ0KPiAgCQlkZXAtPmZsYWdzIHw9IERXQzNf
RVBfRU5EX1RSQU5TRkVSX1BFTkRJTkc7DQo+ICB9DQo+ICANCg0K
