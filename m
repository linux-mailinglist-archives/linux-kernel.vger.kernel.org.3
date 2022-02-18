Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3E44BC04C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiBRTcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:32:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiBRTcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:32:15 -0500
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EFD37A34
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1645212718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LvTvdCFvdJFBM3ivuRgv0dliFymI2OKWYdKSNUBB490=;
  b=Rd8dRhV/jjTpWM8SQ+FtViIeRy+fsHCmvTO7Ys0yZ4z6m/S6uCRoDe2i
   xYq71LaPYmaQzgf+oTUroxbrucKvFBI+jo6le9VrVGAbmerrpKev83FIh
   FeqghHhz8Eg5scec8l5kWvXsU6yXS1Mx3Wdi5cczx7m3Ktioh7+lMFCgJ
   Y=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 66790827
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:mjdeDK9Tusr7SpieI43sDrUD3XmTJUtcMsCJ2f8bNWPcYEJGY0x3m
 mQaDzrXOPvYMzSkf991PIm/oUgDupaAndIwTFM6rHo8E34SpcT7XtnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Sn9T8mvU2xbuKU5NTsY0idfic5Dndx4f5fs7Rh2NQw24HpW1nlV
 e7a+KUzBnf0g1aYDUpMg06zgEsHUCPa4W5wUvQWPJinjXeG/5UnJMt3yZKZdhMUdrJ8DO+iL
 9sv+Znilo/vE7XBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XnRfTAKtao2zhojx/9
 DlCnb6sYFYYAaLUpNkUb0JgFwpVbP1M/qCSdBBTseTLp6HHW37lwvEoB0AqJ4wIvO1wBAmi9
 9RBdmpLNErawbvrnvTrEYGAhex6RCXvFKoZtmtt0nfyCvE+TIqYa67L+cVZzHE7gcUm8fP2O
 ZRGOGI/Nkuojxtna2sUUM4fwvaRgVrAVRx/uAunu/QX2j2GpOB2+Oe0a4eEEjCQfu1Wk0uDr
 WXB/EzyAgsdMd2CzHyC6H3ErunDkDjyRYYUFbCi7dZlh1qcwmFVAxoTPXOgqPy4lkm6RdtZJ
 ko89S0poqw/skesS7HVVhmpu2WN+BsdX9BNCesS6QeRx66S6AGcbkABRyRCLsY7qMs/QzAC3
 0WM2djuAFRHtLyTVGLY9bqOqz62ETYaIHVEZiIeSwYBpd75r+kbnkKRZtVuCqi4ipvyAz6Y6
 yiHsCUklZ0Si8AR3qm29FyBhCijzrDLSQcyzgLJU3ip9AJnaZakdZ6hr1Pc6J5oLp6eT1yLu
 3UsgcWS7OkSS5qKkUSlQOcJWq2u4PKeGDLZiF9rWZIm8lyQF2WLJN4KpmskfQEwb5hCKWSBj
 FLvVR15xoN6bUqVYrdLXouNUPwu5oOxRd7jSaWBBjZRWaRZeAiC9SBoQEef2WHxjUQh+Z0C1
 YenndWEVihDV/k+pNaib6JEiOJwmHhirY/Gbc2jl3yaPayiiGl5oFvvGH+HdagH4ayNu205G
 P4PZpLRm32zvAATCxQ7ELL/z3hWfBDX5ris8qS7k9JvxCI/SQnN7NeLnNscl3RNxfg9qwsx1
 ijVtrVk4FT+n2bbDg6Bd2pubrjiNb4m8y5mZHZwZQf0hSF5CWpK0Ev5X8JmFVXA3LY+pcOYs
 tFfI5nQahixYm+vF8shgWnV89U5KUXDafOmNCu5ejkvF6OMtCSSkuIIijDHrXFUZgLu7JNWi
 +T5imvzHMpSLyw/XZ2+QK/+kDuMUY01xbsas73geYIIJi0BMeFCdkTMsxPAC5tScU6anmPCj
 W57w34w/IHwnmP8y/GQ7YispIa1CepuWE1cGmjQ97GtMifGuGGkxOd9vCygIlgxiEucFH2eW
 Nho
IronPort-HdrOrdr: A9a23:Adeb6q52v+Ip3WvxTwPXwWyBI+orL9Y04lQ7vn2ZFiY7TiXIra
 yTdaoguCMc0AxhJU3Jmbi7Scy9qeu1z+863WBjB8bfYOCAghroEGgC1/qs/9SEIUPDH4FmpN
 5dmsRFeb7N5B1B/LzHCWqDYpYdKbu8gdiVbI7lph8HJ2ALV0gj1XYDNu/yKDwteOAsP+tcKH
 Po3Lsgm9PWQwVxUi3UPAhmY8Hz4/nw0L72ax8PABAqrCOUiymz1bL8Gx+Emj8DTjJm294ZgC
 v4uj28wp/mn+Cwyxfa2WOWxY9RgsHdxtxKA9HJotQJKw/rlh2jaO1aKv+/VXEO0aSSAWQR4Z
 7xSiQbToJOArTqDziISC7Wqk3dOfAVmiffIBGj8CDeSIfCNU0H4oJ69Pxkm13imhcdVZhHod
 J2NyjyjesnMTrQ2Cv6/NTGTBdsiw69pmcji/caizhFXZIZc6I5l/1UwKp5KuZJIMvB0vFtLA
 CuNrCp2N9GNVeBK3zJtGhmx9KhGnw1AxedW0AH/siYySJfknx1x1YRgJV3pAZNyLstD51fo+
 jUOKVhk79DCscQcKJmHe8EBc+6EHbETx7AOH+bZV7nCKYEMXTQrIOf2sR52Mi6PJgTiJcikp
 XIV11V8WY0ZkL1EMWLmIZG9xjcKV/NFAgFCvsukaSRloeMNoYDABfzP2zGyfHQ0Mn3KverLs
 qOBA==
X-IronPort-AV: E=Sophos;i="5.88,379,1635220800"; 
   d="scan'208";a="66790827"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHWy1KSrFgWMXwezdKLqfeHuuENAeSFiQkBT6Cf76qnlN5g+CUiD3rNS4UdlZj2uH5s/qznDw5V+3GWGrmVZ2r68iC99ODr0uGP+3Rh3qPaviTODgbosO/3VwYfh0ldnuAR60GRoBBBg6QUBU+KUi6b0MTxwME0UD14Xa0qqZtXIytgaaAQmNwVOjsmm2FjjkUqCbeqY7SKFGnWncIzARAWXiuUtmxpZyhH2CFteufR9BgQaLpfcu3Ofn7U3FAv8XJ8f1ofdpKD5p+ZdN0kaVxMTathQ0KE2VEXVx0lmtl/BlL82o2gG21ba5oqRqGpF79g5+yszGdBGnGxNW/6Jmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvTvdCFvdJFBM3ivuRgv0dliFymI2OKWYdKSNUBB490=;
 b=XaG/dLifn7D/lnH3ZNqCJd/iEIkKBFRiI2C5KqA4/swv4ocs8FIn4YiqAYbozwQuN/+/zfGo3oQjs9A/QbntWKX7Zsmpn8GgurfHpzKRNIbxu4+I+vTedLePe5CtESOEZUHPqI5V9DDOzf5L7j9Eda8dI77K0rDwD9kvvvnbvByGynMgh7/3OhEM+zSgtYUkkf5oO4tmF7+yP13c35Jpumqx6H9LYjQ9WOmOGGwhXgWnnm34/lYup+wa3uiq587wNUg4Ey5teHp9rc/oS5LyJKqRojlDsQ+jkZ7g1UaTlGGqB4BiTehwICUhEPkj1mf6uySZfpeDKI3G2jTwP09m7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvTvdCFvdJFBM3ivuRgv0dliFymI2OKWYdKSNUBB490=;
 b=M4MFhf62djyKiRZMKYqJ/K7QNY3qK8BfuhfjpALRPJHy+2YXk1ChCKdI8C2s7BbK0LM/cFc+ApBnbcXhlwj3D8o4YTG/4seWMEtT1MSjLbkVjeC4uZ29njxCiX34ZvIV7UbietnwQsS+QOfJEgboDR8RGCngY//H0bR6daTaUts=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 14/29] x86/ibt: Add IBT feature, MSR and #CP handling
Thread-Topic: [PATCH 14/29] x86/ibt: Add IBT feature, MSR and #CP handling
Thread-Index: AQHYJOshPUTSIDfqfUeaFrSO4dPJDqyZsnUA
Date:   Fri, 18 Feb 2022 19:31:38 +0000
Message-ID: <c96d394c-d98e-1ff9-4919-a561c585d4a6@citrix.com>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.395399333@infradead.org>
In-Reply-To: <20220218171409.395399333@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b524abc3-eda1-4565-ba4c-08d9f31548c4
x-ms-traffictypediagnostic: SN6PR03MB3743:EE_
x-microsoft-antispam-prvs: <SN6PR03MB3743BECDBED65E6AC982962FBA379@SN6PR03MB3743.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8j81qrrqr8zt5MUGURHuWI+3/foM0Ek6e1LzlAqhS8/DPg5mng28ingIGZmUHfJcFNwg5Xo/b06CF5XQCQeFwSfaTioYccS2kd72lx2tdvOKfXcUoL7h4iYghsCYECe9dV2Aow5GqK3YW/SElqRPioOpnQGYPPTGe5zgsZ9LugEJg6Or5oOD6xtQxAxgjMXcea1o8Dew0sla7u5a58IY9gn6sMQvXnxCQXAguF8xG3kr4zYSom7ntMM0g0dMkqDcZlX4JD9QcM+afrr4F+g1v6DBVceT2b5mvY+VkAit1CMKQ/VnB8WHnNJsJY9YOVpvdb4soOjgdrgfWndn0r8MmQeAZWMTvuuv+PF7T6nhid/YaSrq39OhMrsH4kTxuA1pnJkoDDq9YpImesHNOOyxoJxcMVBJWKzIUtnOptXJpwBjuHLsxYfGBQPS42Rqlga5rKfF2PYxrkqoFeA3iPL70AMt/SCnjJncZdPkizC+qc48rhbyBnnXu/ug3Ee4tcoi74ZpkYJNW11KSxCj+9pNaKAPA1mWmxJaPsddqopgtlxdwoj6grl0tDbXyjEI7eCSh7U5A+A9MdGq7ilcf+pggcJ65j+Zet2B0BXXaR5wbwYlfspiQkqbAUfCPIf0U8ePR5V1WzOCQRC3/hHiXDnM938aHpLX5iSfLki6pASzR5St07mUAQuGg2poLNDXjGSs8/jRAavRv4cp+IVwn8g8vxE4aj+ARwfz7VOnGtgTCK/HWdsXZznMhdrs8/Fh0qz/dM2rufifTNCo4n3ZcdJu4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(86362001)(66946007)(5660300002)(38070700005)(66476007)(64756008)(6512007)(66556008)(8676002)(4326008)(71200400001)(508600001)(91956017)(82960400001)(76116006)(7416002)(122000001)(2906002)(26005)(4744005)(186003)(31696002)(316002)(8936002)(54906003)(110136005)(6486002)(36756003)(2616005)(6506007)(53546011)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVgwS3N4blQ0MVltczFYQWE3WFVhdlRWTWNGcG55ajdJTE5wL3FZOU1hVVI4?=
 =?utf-8?B?N3RTV0Frb1lHdUpGSlNadjd1NW4zSlZOMnZuMGxtL244L3JoeVdobXQwTEto?=
 =?utf-8?B?L3EvanJIOFYvMmlReTYyOVJDZjNyTlRadEwxOUgwMEMydHhRU3Q3d2VOTG1H?=
 =?utf-8?B?MDVYcjY5aWhSZGJCckc1dWRUcUhlZitFbUdEYWJ0bFNPSCt3L0tSNUtJZ0tz?=
 =?utf-8?B?UEp4V2tyWE0zTk5Od2ZlYkpZNW1QQmo0YUo0NnIzVGZRUk5RbEU1MkZzWUtB?=
 =?utf-8?B?dG9WYm5abEIzRTE2N3NUa3Y2bWgxM2VCTWFoQWxZTVdDVFd0K0ltYjNvRWV3?=
 =?utf-8?B?REo5dUU0SDZKaStsUDYxVE9PNWZIS0FnQXVpSkMxTW5SM2grVmpLR21nVWJq?=
 =?utf-8?B?dUQrRFRoeC9Fc2JWbFovcmllUk0raUFxamZpZmltWGNROTl0TTVMUysxZzUw?=
 =?utf-8?B?anJTbjZmci9GdzkxVU1CcTlmR2F6SGVOTFNSMjNiN1MwU0VZelp0ZkxVMXVz?=
 =?utf-8?B?Q0tlT0d2Qm5UcHlQMFdOL05mNENOTzJESGRIVFowa2pGMmxxSExYRWRJNkRS?=
 =?utf-8?B?WGJmOXRSYnhBWkFxV0lINEVIWVN4V1FwUHk3VGJQN0dLUnpoSjYwWk44UC94?=
 =?utf-8?B?Y1VWTzZkdDhpNXJPbGZOMUUrdEVjVERJTkF6TzNIeEg5VXZCS3UwdDVma3JK?=
 =?utf-8?B?ZlJRVGZBMzJWN3dabXRLMnhQUTF0TFduYmtvbUU4VFVraDNycUlNSlRxSGIv?=
 =?utf-8?B?UXBMSXphNE16ZXlocExIZDRDc1lLMjN3bldxS0pZaXBpenl5TGlxMU9LSlFp?=
 =?utf-8?B?dDFiczUwbEtZbUhJeEtWT0hDMWgxMHdOVVZHRUVzNEUxZ0pPeTBwMUIvN0pX?=
 =?utf-8?B?eVBVTitkd0RpUHZSNzY0UEFGNGFTSW5ZK3V5cHRWalNXUkw5aGdVSURNQ2NI?=
 =?utf-8?B?RGJXdDNnR2I4N0xLQmN2RFZmdlRGakxtdUxlWm5GUWRKVGNXWDJ1YWhRMTlp?=
 =?utf-8?B?WWtBV3VMczQzNThCdGQvTW5XdjRuUlFMeko5L1dvOEdrQzlEL0dpUHhPeEhH?=
 =?utf-8?B?TDJiTU5iOUZnNVVldGpaemNSYndGTHdEbXJBYWZ0SGhTMUxmdEhZT3RWdmQw?=
 =?utf-8?B?bEQ4MzNrdS9zVzVaMFg5NGF3NlNPZE5XTUl6Ujc5R0pHZzZyeEhYR1ZPT3Nj?=
 =?utf-8?B?TU0vT1RvaldTZWdPNFRBd0VYQ3pNYWpGWWZselY1MnVDSkx2MzJvdkZZejlD?=
 =?utf-8?B?US92VlRiOU02VnNxNS9jeFZRY0x3dkNid0ZOYTNodnlTSjVkQ01KZmRKVHVY?=
 =?utf-8?B?TWZKWHRpVXZhQzBlTnAxNjVPUW9DVlVDVGV1UzdPdjhOeTFWOXpvdmVudXpa?=
 =?utf-8?B?alRJSU9pMHpBNVJDQWQ4UWx3SlVkSjR2MW1IeDFTeDgyQi81WmE5ZWxPQ2Fh?=
 =?utf-8?B?U0JmcDM4T1Myb0NPY1VVSkZBZ2VNTU44WkQvWFhwV2RLV2FRTVRxMUYvMHhF?=
 =?utf-8?B?Znl5Tlk5ZXRSR3Jrc3VMUmlxb2JSemROTnZFeXFSNmVHRjdpU0toSzgzMjZl?=
 =?utf-8?B?RllkRWx2dWVBS1ppQ1RBMGNYQVNCZThxMndkdFM0SzliTDEwZElWM2hTZ0JY?=
 =?utf-8?B?a29JbW5vRXlSbmpQaCtyc3BHOXgxV2h5dmhUZllncG1sQ1lySVZkdWtxWUY0?=
 =?utf-8?B?bGtNM0crV2lqazNxa01aQ2FtZU9jWmFqcjV2aGJGalduOEs3ZlBOQ05uVzU5?=
 =?utf-8?B?MGRvQ0pNeEk0dmNSeE9oNmxKL2c1UHF2V0loVGFiYWRkaDV2cEg0bGpKeGdw?=
 =?utf-8?B?T29LUVFGczVJYXFNdlFjeTkvQ1NaWVQ0MWtTZlJGVDlnT3Q4MW1OaFNaTUtP?=
 =?utf-8?B?TjFwTkZPbDBOcW44cGQ2aFJRcTIwMnhFZnFmTnhzb3lSWHM2VkNLdVdtVWVv?=
 =?utf-8?B?ZTF5SUVheUpFR0ljenlTanVLbWU4bGY2TjArZEpNdy91Sm42aGMrN0NNNU1o?=
 =?utf-8?B?Mkw4cGlUMFk1ejlJbXIwbi9kQ2lhWS9MSHNvNFU0VFIvZkJtY1JRQ3ExZnR0?=
 =?utf-8?B?TTN1dWtWQXIwS0RESll2OHlzMmEyWnQ4Rmx0U1FTYTduSzBxYXBGTkc3b0I0?=
 =?utf-8?B?SDB5ckZVZmpqbHMzWU56S09Ea3cvNlBKYmI0b2h5YTA1bDBPb1FSNUZzQm81?=
 =?utf-8?B?Qk9oUTZWbXFlZXFmMEIvdk8vbDFLUElEMDN1cXg2V1I3WHdZdGVhQ2FoSktN?=
 =?utf-8?B?MEpzSnJOdG1VclZQL3A4cVkvNDFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4682F84B654F934CB4F3571FD9793D32@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b524abc3-eda1-4565-ba4c-08d9f31548c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 19:31:38.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGTzNAlWZ8syYpo7kXvHLnExITRcnMFRInz+7UagWrp7l/9NfpdRAMPdWJ6lGBF4cohZ59e8KgIrUBMjvN0yI5B73ciHUtEr+RNO2KMJb+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3743
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDIvMjAyMiAxNjo0OSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IC0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21t
b24uYw0KPiBAQCAtNTkyLDYgKzU5MywyNyBAQCBzdGF0aWMgX19pbml0IGludCBzZXR1cF9kaXNh
YmxlX3BrdShjaGFyDQo+ICBfX3NldHVwKCJub3BrdSIsIHNldHVwX2Rpc2FibGVfcGt1KTsNCj4g
ICNlbmRpZiAvKiBDT05GSUdfWDg2XzY0ICovDQo+ICANCj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxp
bmUgdm9pZCBzZXR1cF9jZXQoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0KPiArew0KPiArCXU2NCBt
c3I7DQo+ICsNCj4gKwlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX1g4Nl9JQlQpIHx8DQo+ICsJICAg
ICFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0lCVCkpDQo+ICsJCXJldHVybjsNCj4g
Kw0KPiArCWNyNF9zZXRfYml0cyhYODZfQ1I0X0NFVCk7DQo+ICsNCj4gKwlyZG1zcmwoTVNSX0lB
MzJfU19DRVQsIG1zcik7DQo+ICsJaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVf
SUJUKSkNCj4gKwkJbXNyIHw9IENFVF9FTkRCUl9FTjsNCj4gKwl3cm1zcmwoTVNSX0lBMzJfU19D
RVQsIG1zcik7DQoNClNvIHNvbWV0aGluZyBJIGxlYXJudCB0aGUgaGFyZCB3YXkgd2l0aCBzaHN0
ayBpcyB0aGF0IHlvdSByZWFsbHkgd2FudCB0bw0KZGlzYWJsZSBTX0NFVCBiZWZvcmUgaGVhZGlu
ZyBpbnRvIHB1cmdhdG9yeS4NCg0KSSd2ZSBnb3Qgbm8gaWRlYSB3aGF0J3MgZ29pbmcgdG8gcmVz
dWx0IGZyb20gVUVGSSBmaW5hbGx5IGdldHRpbmcgQ0VUDQpzdXBwb3J0LsKgIEhvd2V2ZXIsIGNs
ZWFyaW5nIG91dCB0aGUgb3RoZXIgSUJUIHNldHRpbmdzIGlzIHByb2JhYmx5IGENCndpc2UgbW92
ZS4NCg0KSW4gcGFydGljdWxhciwgaWYgdGhlcmUgd2FzIGEgc3RhbGUgbGVnYWN5IGJpdG1hcCBw
b2ludGVyLCB0aGVuDQppYnRfc2VsZnRlc3QoKSBjb3VsZCB0YWtlICNQRiBhaGVhZCBvZiAjQ1Au
DQoNCn5BbmRyZXcNCg==
