Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90569579797
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiGSKYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiGSKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:24:44 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43E31A3AD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1658226282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4XbTDeimnfmvjeepgh0C0jmlP3dI38h9NuWdu6X4G6U=;
  b=bMtcI2jbzNiOA8MyppCWVim3UwCBAaJtWBrMRvbvOPkDPOmY3eWbzPau
   zRVuW9uHFPhAjU32lTKvqdvXrkhJA6E57Yc1pxz6udSyhHW3cDtjaraHq
   wyglCcPVw3X5Q6Aa4FWfX+NS9a3WZbngsNKes2IhCFDJ7CuB304/NOjhm
   I=;
X-IronPort-RemoteIP: 104.47.55.171
X-IronPort-MID: 75931638
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:rYzu9aifP4GtzGOXehudhK+BX161cxcKZh0ujC45NGQN5FlHY01je
 htvW2CEPPaDZGH9edFyPd/k/RwEv5SDm9FlSgo/qCw3FHsb9cadCdqndUqhZCn6wu8v7a5EA
 2fyTvGacajYm1eF/k/F3oDJ9CU6j+fQLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtH8CA6W0
 T/Ii5S31GSNhnglaAr414rZ8Ek15Kur6WtB1rADTasjUGH2xiF94K03fcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD90V7tJOp6iGqE7aua60Tqm0xK6aID76vR2nQQg075TCRYpQRw/ZwNlPTxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJQWXAP6I0DuKhPRL/tS4E4eH4dJ3/lbBENy6
 KI8c24MNT6oruazz+fuIgVsrpxLwMjDGqo64ysl5xeJSPEsTNbEXrnA4sJe0HEonMdSEP3CZ
 s0fLz1ycBDHZB4JMVASYH48tL7w2j+jLHsF9RTM+vNfD2v7lWSd1JDENtbPd8PMbsJShkuC/
 UrN/njjAwFcP9uaodaA2i3x17SWw3irMG4UPOekqN17vFij+lAaEDkJBHa9ptWnmmfrDrqzL
 GRRoELCt5Ma6EOvXvH5XhulvGSDuB8MHdZde8U+6QeQ2u/X7hyfC2wsUDFMcpoludUwSDhs0
 UWG9/v5VWJHs7CPT3+ZsLCOoluaJS8PM2YGaTQsSQoD/smmroYuiB7GUtdkFuiylNKdMS3xx
 naB6iM+irM7ic8NyrX9/FbbjjbqrZ/MJiY3/gLWW2ii4yt6aZSjaoju7kLUhd5YJZmQSB+Co
 X0NgY6R8fgSBLmJlSqQUKMMGq2k47CONzi0qV1wHpon+i6F9mKjb8Zb4FlWLUN4Kd0NPzroZ
 EXOowV54J5VIWvsbKlrbob3AMMvpYDiHNLjVtjbad1BZpU3fwiClAluZ0rWw2fqlFMEnqQ2O
 JPdesGpZV4YDq1gij+xXeocy7YDxyYiyGeVTpf+pzyl1qGTfH7TT6oXNVKIRuE/8K6A5g7S9
 r53LcyR1xhTTMXxZS7b9I8Ia1cQIhATB5/srNdMXvWeOQcgE2YkY9fJzK8sYZ5NnqJbjO7E8
 3ixHEhCxzLXgH3GMwyPY2xLa771W5t763UhMkQENE2083sue4Ci6OEYbZRfVbUu8u1uydZ1S
 PYIct+KBeQJTDnbkxwefILVqY1pbhOwggySeSGiZVAXf5dhVgXP9c3Mewrk7i4VCSSr88A5p
 tWIzR/bTJ8GRgJKCcfdcvW0yF2t+3ManYpaQEbJZN1SZW3v/ZJsJii3ieU4S+kAJB7exxOf1
 g2MBgwfq/WLqIgwmPHMhKOJq4OkAsN7H0FAGHLc46rwPi7flldP2qdFWeeMODrbBGX9/fz4Y
 f0Plq6ldvoagFxNroxwVa5xyr4z7MfuoLkcyRl4GHLMbBKgDbYIzmS64PSjf5Zlntdx0TZak
 GrWkjWGEd1l4P/YLWM=
IronPort-HdrOrdr: A9a23:MlpUS6PMG82bcsBcT2L155DYdb4zR+YMi2TDiHoddfUFSKalfp
 6V98jzjSWE8wr4WBkb6LO90DHpewKQyXcH2/hqAV7EZnirhILIFvAp0WKG+VHd8kLFh4lgPM
 tbEpSWTeeAdWSS7vyKrzVQcexQpuVvmZrA7Yix854ud3ASV0gK1XYaNu/vKDwTeOAwP+tdKH
 Pz3Kp6jgvlXU5SQtWwB3EDUeSGjcbMjojabRkPAANiwBWSjBuzgYSKUiSw71M7aXdi0L0i+W
 /Kn0jS/aO4qcy2zRfayiv684lWot380dFObfb8yvT9aw+cyTpAVr4RHoFqjwpF5N1HL2xa1+
 Ukli1QffibLUmhOF1d7yGdgjUImwxelkMKgWXo/UcL5/aJCg7SQvAx+76wOHHimjUdlcA536
 RR022DsZ1LSRvGgSTm/tDNEwpnj0yuvBMZ4KcuZlFkIPwjgYVq3Poi1VIQFI1FEDPx6YghHu
 UrBMbA5OxOeVffa3zCpGFgzNGlQ3x2R369MwM/k93Q1yITkGFyzkMeysBalnAc9IglQ50B4+
 jfKKxnmLxHU8dTZ6NgA+UKR9exFwX2MFrxGXPXJU6iGLAMOnrLpZKy6LIp5PuycJhN15c2kI
 SpaiItiYfzQTOaNSSj5uw6zvmWehTNYd3E8LAs27Fp/rvhWbHsLSqPDFgzjsrImYRsPvHm
X-IronPort-AV: E=Sophos;i="5.92,283,1650945600"; 
   d="scan'208";a="75931638"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 06:24:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WET3h2jyNDlO31L412R/v6Wynyk2tSgut8+nMdHvj+g/E103+Fi5cK3mOVS8r3HnpGmTmHhajMOh4V9/DUiWgy9wpZpGFXNnu2lb44rK8fLCIhjBoKCU7/7KtTcbRJ7z1fqAAjXN9WpF4jthUBwd+lWr666BcAQSBdBiv/Z246+bODwbKXicpUpO3O7VrwdxAecBeB6Hc0YJUd/nOvjeLH6siDzorAXhbcLKS99P7ZHhayoBYAuMJd8lp7KeTfpQ4HOAZCD8IjbZbqZsrFvWlyvrswKMFwjo/pxSj6yAUo6wb5ZtnbSgLFG/7UEusHh2I+oJUvHf8K0uOIZK4FwHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XbTDeimnfmvjeepgh0C0jmlP3dI38h9NuWdu6X4G6U=;
 b=bTN2prSflO9ur3biMsL+bZ4y1+uDuznt8a0lAkR2AzPaQp+Mj/CSwWZ5Ug/7evULTiLl9G/6cNZ0Gx5keHOvYUigkDsh49XpCQaPNACw0sCLmcuwTNoFBFe292NBmsFu7RV/ZMKkx81MlH+IOA/rOmzW/FXYJmQCcCojFUt52DIqMTSvIS0nX/eOAdsVZPNBlr7tJAssrzKH2Tz1lbmCj1u12axF5UXBY4kIaz5D5xbQklRtUqRPILi7VnVYrusryV99Z33xk2dIQrAj/gwucBkxmb42UDbTehQUJyhPvHEK6Kazm/Cg59OI0ikpJUXhffcFc2FOW3hjwg2yobLUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XbTDeimnfmvjeepgh0C0jmlP3dI38h9NuWdu6X4G6U=;
 b=qmsRkzac7epeTCTHgD9MVFT9RYUiJTK+uyh/SdCgn6fOBYx/mIDsDi4lwZzXmdPVmhTGe6gBEe/I0S0FiO1/jg6aIrL2kvXSRTIkJ1sDDghqDUrSmdeEY+zYOWipDi2FhKzmy7bVJEKNxRTIXFeEHVSjjsmywXlzqIr+FQQ79OI=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB5664.namprd03.prod.outlook.com (2603:10b6:a03:28f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 10:24:35 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c%4]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 10:24:35 +0000
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
Subject: Virt Call depth tracking mitigation
Thread-Topic: Virt Call depth tracking mitigation
Thread-Index: AQHYm1m+Rhbzf0W840KUAhk5fXVBkA==
Date:   Tue, 19 Jul 2022 10:24:35 +0000
Message-ID: <4ca4a4ab-6ea0-d94a-59cc-1ab99ff869d5@citrix.com>
References: <20220716230344.239749011@linutronix.de>
In-Reply-To: <20220716230344.239749011@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fc6af07-25cb-4b90-d90d-08da6970e092
x-ms-traffictypediagnostic: SJ0PR03MB5664:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xWoLAY3TNIU2YXbRlbYOHIawdBj50G8NevUnFKZKTMlASPWbm2uv+2bay1Ar+/qa+04kib873qzifK2CQ4fE2UtXqjDX3XRUW8jJjjtno3CqJSjrefhQUNfN3sZIOJQTtTR/y4x36PctVnmDT4V0qhrER1DvZJf+O7TiXRb7lr5WbtH25sLhPiNhg7cFJv1I0bweA3ESDMLBnBQG1slPte4m7Z/m7rSFpuxN0mpFWqhNf7aTYsRxZjfcA+YJ71TmNqmj2m2LkASAnw2An2ji7dBl4C5/qshp6XJzD8FjSO01AyS2dIjPFtjPDc1dQRXhiJJyHOpuPiXgICcZsSmBB1ZnJQmVMJwWrW6GAwVjLh/Huy0vawTouUF1lZ2p08libLtovYYQYEmBlOmzeNeLsAD7xm9oZEPYrUaSu1jqgP5/0L7NBSHuuQtwMzfrAdLkrQkzQEiuE7mXYfUq8fCWC2l8gwY6ZsJXLiIItGqCS3CTL9YAvFyPNycd8odIwQD6g31Tev6P83PXxNPzycRYi8D2P7269aj+WhqRG8JZBcP5zzzMMdGGQqVjiY8o8p4jgou8s0L2ATRzqMmh5rRC1v+0u4Ltf0W/4qu4oQBQx4ggG8PZmQg8K55plbK3cENAbgL8KbzLBIsiDhKJ2kaR+EVVwxUjDJYk1db8PLkUWizuzIg7d91YrWe6/SRD268vnp8Ca145d6HU1rn9AlpifCtYxSevhn+msFMrWLH3sdn70Q6HL44vgR+43eowandYQOKDiy/G8jeKeVNzjrMayjVFCrmpWRUPhessAPjDQ0Yj84G8PUaeQ+fqwe64qJaKmKE37T7s4u3pAfT80tmtXgcDj0BggLnxeBOmtLQUvXI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(6486002)(41300700001)(86362001)(71200400001)(186003)(478600001)(6512007)(82960400001)(53546011)(122000001)(2616005)(38070700005)(26005)(38100700002)(6506007)(66556008)(83380400001)(66446008)(66476007)(66946007)(31686004)(2906002)(7416002)(8936002)(5660300002)(4326008)(316002)(8676002)(76116006)(110136005)(31696002)(36756003)(91956017)(64756008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0dpMVF6QjVpdVJ0KzJEbE85bi94cE54V3pHK1VydnlieHErYlVkM0lrQ3NF?=
 =?utf-8?B?eFlVTHpnbURqR0pxM2dCeFZES1VGWXY2OFhRQUpWeUo0Tlp2Y2Rma1g3Nldx?=
 =?utf-8?B?YkMvTUlxbWU0cXpXam5kWTVEazhIQUs3eTFSVU1xbFZRTk5kVFNkcmdKaUlX?=
 =?utf-8?B?WitDVEVzR3gzeENCQjZrUmtjMGhSa2N0cG5tWFpYNUl6cTVDYUNYNnZIcHRk?=
 =?utf-8?B?dW1GTEozZEFidXpPcXVkeE4wQmxRK3dURm5weVRhVEZmOWM4UXF1UjNCQTRI?=
 =?utf-8?B?ZHVmZ1kyQk5GNGltUVVXZXljKzBiaVRxa0xNQ3BVa05DejV6M1drbW12Rk9X?=
 =?utf-8?B?cUtJcExHNlFzR1pIOU5OU29kOUw5dDJPcmN2OHlvVE02QWhQL3gvZnlBS1ZQ?=
 =?utf-8?B?MWNabFR4ZjJXL2g1MUVFZkVGVVBYK1hUb2lHeXpzYVlvd1RJckE1TUhLejlp?=
 =?utf-8?B?Y1ZYSTFDM1YxbUhmR01pTjRnRFJDU29oSEt6QU1GMkpKM2RJT2JCVTkyNXly?=
 =?utf-8?B?VitQRTJQQzNhSVpOM09XNW8zY0hSdjdZcU5xZFBvSGU0LzEwNCtwSERUUEVE?=
 =?utf-8?B?ZFJyUUxLd25iWW1JSFJEUDdrb2xBbnRnTHdvempFUlhFeVZzcG5IVEw3UTh4?=
 =?utf-8?B?Yk1DMkZLMGVZR2lnbGhXWnRlM2tBanY2ejV5SUZXYi8xRHJzUjBYVDhHa1BP?=
 =?utf-8?B?ZENzVTJENXEvL1ZNTVU3bzdJdkMvQk1VUG8wUEZvUHBHN0c3Y2IvYnZxTlkw?=
 =?utf-8?B?R1ladkc5eFhFTEpJbTFVL3hZY2tuWjZYWG9EaU9OYmRGYkJGSTJRSUFxNkN0?=
 =?utf-8?B?c2lhUnlNVkRWaDRUMDhlQmNXa3Z1ZkRaUmN5TG1MaVhtejFxN09mK0djOHk2?=
 =?utf-8?B?d3ArdmpKTWI1alMvVyt1QnFsWlJjTnBhR3RnS1ByeHpVajRrQVJnZTYvM3hI?=
 =?utf-8?B?a2tBc0FpQ1Q5dzdac2NIS2VQWnFYeDFMazhiMXFRdlhxbFdtQVhkUm5rWHFn?=
 =?utf-8?B?Wm5Ldm15RUF3cHJRVFNoQ2JQdFFoLzJjQm9oOVhUZEJRakFyR0ExZDFCVGQw?=
 =?utf-8?B?NjFUNHFGSlpkL3FQWmI0aG5rU0l2TWZaSnFiK0Q5aWJOQ3RrUi92ZWhXdHV6?=
 =?utf-8?B?OTJrOGE3MGNZZ2wrZlhmMGRWMmUvTzExNGVwNjluU29pelRSamE1bktpUTdQ?=
 =?utf-8?B?UlpQcFRIZDliNUtjWHpmU1BaQUdYaTBmMEdpK1lZYS9MM1FKbGtVOEIxa1or?=
 =?utf-8?B?dmEyclg1eS9MTVk1d1ZSdW81UlNPVUxLdGRBbktjWkpVV1VtZFY1VmdFQjln?=
 =?utf-8?B?d080ZjE0UUtWaU50KzI5ZlhrM2JVR2Frd252VzlGTk95K1FEeU9Bc0E1WE9k?=
 =?utf-8?B?aW42WUx1bUVyVlF4N3hTMUplQmlGa3hDOG1NZTlTL2JhZDN0Q0pPK3RCRlFM?=
 =?utf-8?B?OTJWVXZCYzlhTmVIOEl1R0oyQnRsT05tOU1WazdXbTRXTHdSWGQ2NXo5WmMx?=
 =?utf-8?B?MnNWbncwOHpuOVA0YTVLU3k1MlRFakRlY09BVUx2aHZKUDUyWk9kd2dHemVl?=
 =?utf-8?B?bWU4VGwrRy9lRm1zRm1TUWtreDJZMXFZS2NRMnpIem45T05GZGxlM1NyZzh5?=
 =?utf-8?B?TFgxbnNWbFVnQUEycmxpblNpTWpHNW9LaEttK3VnZ1FrY283N3ZXUUU0WFJt?=
 =?utf-8?B?OHA0MkVmOUdZTkJFaFYwVmFMdTV0V0dQUDA1ZVdDWUt1TEV1UFEzOFhGZEdM?=
 =?utf-8?B?cU1iUmRaNkx1VldLV1g5QzRTNm4xS2F6bzQ2OVRYTDQwMlpLNldNU0pPeUxo?=
 =?utf-8?B?WWtMbTdVME9MTnpjUUcxRzI2bHdHK1FadUx5SkQwdWl6dS9sRzFPanEvbDZL?=
 =?utf-8?B?MmI1b3RCcW9vbkFWWTJocDBmN3BZUU1zL0xBRFdOZmp0cDN6bnhzQzR1NHZ2?=
 =?utf-8?B?THEwKzZCZDY3THN1NEhKVkVMaC8vV0NVNVNIeE5RSHo1ODVtRHAzaG54K01i?=
 =?utf-8?B?a2VmYnBBdkphRjBETVZFR3BXOG1lWCs2SUxXTGhXNjlkSTIxUFVQTHdsU0ZT?=
 =?utf-8?B?UGJYb0JCRCsyMkU5cWtOelFDWDN6Sm9BdWo0S2ZkS00yb2pZM0RBZjJEdDJ0?=
 =?utf-8?B?QlVVRTllWGpJMW5TeTI5NzlYNEJCWFdQNm54L1AyQ3Y5VjloNkdCVzN4SjQz?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1397467A29290E42947D480A06E4E803@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc6af07-25cb-4b90-d90d-08da6970e092
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 10:24:35.0851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VhioZosd5BbK7BktHJIGQxi78AyIEUq2iDQz+4jWizgEmE1pSPB9HZNcH/xiPthF9IYyJ376kU15WdNTsUP+SGovt1WGLBONu4JtEPX6IUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5664
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcvMDcvMjAyMiAwMDoxNywgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBBcyBJQlJTIGlz
IGEgcGVyZm9ybWFuY2UgaG9ycm9yIHNob3csIFBldGVyIFppanN0cmEgYW5kIG1lIHJldmlzaXRl
ZCB0aGUNCj4gY2FsbCBkZXB0aCB0cmFja2luZyBhcHByb2FjaCBhbmQgaW1wbGVtZW50ZWQgaXQg
aW4gYSB3YXkgd2hpY2ggaXMgaG9wZWZ1bGx5DQo+IG1vcmUgcGFsYXRhYmxlIGFuZCBhdm9pZHMg
dGhlIGRvd25zaWRlcyBvZiB0aGUgb3JpZ2luYWwgYXR0ZW1wdC4NCj4NCj4gV2UgYm90aCB1bnN1
cnByaXNpbmdseSBoYXRlIHRoZSByZXN1bHQgd2l0aCBhIHBhc3Npb24uLi4NCg0KQW5kIEkgaGF0
ZSB0byBhZGQgbW9yZSBwcm9ibGVtcywgYnV0IGhlcmUgd2UgZ28uDQoNClVuZGVyIHZpcnQsIGl0
J3Mgbm90IGp1c3QgU01JJ3Mgd2hpY2ggbWlnaHQgcnVuIGJlaGluZCB5b3VyIGJhY2suwqANClJl
Z3VsYXIgaW50ZXJydXB0cy9ldGMgY2FuIHByb2JhYmx5IGJlIGhhbmQtd2F2ZWQgYXdheSBpbiB0
aGUgc2FtZSB3YXkNCnRoYXQgU01JcyBhcmUuDQoNCkh5cGVyY2FsbHMgaG93ZXZlciBhcmUgYSBk
aWZmZXJlbnQgbWF0dGVyLg0KDQpYZW4gYW5kIEh5cGVyViBib3RoIGhhdmUgaHlwZXJjYWxsIHBh
Z2VzLCB3aGVyZSB0aGUgaHlwZXJ2aXNvciBwcm92aWRlcw0Kc29tZSBleGVjdXRhYmxlIGNvZGUg
Zm9yIHRoZSBndWVzdCBrZXJuZWwgdG8gdXNlLg0KDQpVbmRlciB0aGUgY3VycmVudCBzY2hlbWUs
IHRoZSBjYWxscyBpbnRvIHRoZSBoeXBlcmNhbGwgcGFnZXMgZ2V0DQphY2NvdW50ZWQsIGFzIG9i
anRvb2wgY2FuIHNlZSB0aGVtLCBidXQgdGhlIHJldCdzIGRvbid0LsKgIFRoaXMgaW1iYWxhbmNl
DQppcyBleGFzcGVyYXRlZCBiZWNhdXNlIHNvbWUgaHlwZXJjYWxscyBhcmUgY2FsbGVkIGluIGxv
b3BzLg0KDQpXb3JzZSBob3dldmVyLCBpdCBvcGVucyBhIGhvbGUgd2hlcmUgYnJhbmNoIGhpc3Rv
cnkgaXMgY2FsY3VsYWJsZSBhbmQNCnRoZSByZXQgY2FuIHJlbGlhYmx5IHVuZGVyZmxvdy7CoCBU
aGlzIG9jY3VycyB3aGVuIHRoZXJlJ3MgYSBtaW5pbWFsIGNhbGwNCmRlcHRoIGluIExpbnV4IHRv
IGdldCB0byB0aGUgaHlwZXJjYWxsLCBhbmQgdGhlbiBhIGNhbGwgZGVwdGggb2YgPjE2IGluDQp0
aGUgaHlwZXJ2aXNvci4NCg0KVGhlIG9ubHkgdmFyaWFibGUgaW4gdGhlc2UgY2FzZXMgaXMgaG93
IG11Y2ggdXNlciBjb250cm9sIHRoZXJlIGlzIG9mDQp0aGUgcmVnaXN0ZXJzLCBhbmQgSSBmb3Ig
b25lIGFtIG5vdCBmZWVsaW5nIGx1Y2t5IGluIGZhY2Ugb2YgdGhlIGN1cnJlbnQNCnJlc2VhcmNo
Lg0KDQpUaGUgb25seSBzb2x1dGlvbiBJIHNlZSBoZXJlIGlzIGZvciBMaW51eCB0byByZXQtdGh1
bmsgdGhlIGh5cGVyY2FsbA0KcGFnZSB0b28uwqAgVW5kZXIgWGVuLCB0aGUgaHlwZXJjYWxsIHBh
Z2UgaXMgbXV0YWJsZSBieSB0aGUgZ3Vlc3QgYW5kDQp0aGVyZSBpcyByb29tIHRvIHR1cm4gZXZl
cnkgcmV0IGludG8gYSBqbXAsIGJ1dCBvYnZpb3VzbHkgbm9uZSBvZiB0aGlzDQppcyBjb3ZlcmVk
IGJ5IGFueSBmb3JtYWwgQUJJLCBhbmQgdGhpcyBwcm9iYWJseSBuZWVkcyBtb3JlIGNhcmVmdWwN
CmNvbnNpZGVyYXRpb24gdGhhbiB0aGUgc2hvcnQgdGltZSBJJ3ZlIHB1dCB0b3dhcmRzIGl0Lg0K
DQpUaGF0IHNhaWQsIGFmdGVyIGEgcmV0dXJuIGZyb20gdGhlIGh5cGVydmlzb3IsIExpbnV4IGhh
cyBubyBpZGVhIHdoYXQNCnN0YXRlIHRoZSBSU0IgaXMgaW4sIHNvIHRoZSBvbmx5IHNhZmUgY291
cnNlIG9mIGFjdGlvbiBpcyB0byByZS1zdHVmZi4NCg0KQ0MnaW5nIHRoZSBIeXBlclYgZm9sayBm
b3IgaW5wdXQgb24gdGhlaXIgc2lkZS4NCg0KfkFuZHJldw0K
