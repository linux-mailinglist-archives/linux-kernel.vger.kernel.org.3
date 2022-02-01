Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448534A5AF1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiBALN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:13:27 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:45222 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiBALN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:13:26 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220201111323epoutp03a816168c346af5c940b8a9a21bc2bebb~PpS2GkSqg1132111321epoutp030
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:13:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220201111323epoutp03a816168c346af5c940b8a9a21bc2bebb~PpS2GkSqg1132111321epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643714004;
        bh=ChhcF1NoORvS1k+xf7ga/YjFUmM2ShmAbsLkCpu8fL4=;
        h=Date:Subject:Reply-To:From:To:CC:In-Reply-To:References:From;
        b=srhfqMY1mATVRdHSLvSvTUWaqJXhC5A6O93ECZpAhxz6cOGpYcg/D7A4zV9ERAIu6
         Qub/V9vbSuUbBUQN9Ftqgg+6R4eoGD0hFb8Q5QwLJNMNQy2NZb9W30ObiUILjHCq/5
         8ETnA9n18t4zbo5v1RsoU9juAs1s1FnwvQz2x6Iw=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220201111322epcas5p3d59eb6cb20c16c227f96996f76eefde1~PpS0ymN7b0747107471epcas5p3T;
        Tue,  1 Feb 2022 11:13:22 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-d8-61f915968964
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.F0.46822.69519F16; Tue,  1 Feb 2022 20:12:22 +0900 (KST)
Date:   Tue, 01 Feb 2022 15:54:23 +0530
Message-ID: <483084104.1497479.1643711063683@mail-kr5-2>
Mime-Version: 1.0
Subject: RE:(2) [PATCH 1/1] kallsyms: print module name in %ps/S case when
 KALLSYMS is disabled
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YfkBQNBEPrAJ9jKw@smile.fi.intel.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
X-CMS-MailID: 20220201102423epcms5p7e0fec070047e3134bcb698511aa55761
Content-Type: multipart/mixed;
        boundary="----=_Part_1497478_934560393.1643711063682"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG951bS2fJacHtlToIVYeggLI5jtFdTJw5LiTTbIpxTHYCJ2CE
        0rRcxM2EkU4mgsxxtSJ2SBRKQwGBNly6gcyBsFB1LgVlFAqazDBRdCiMMMpps/33+573ea/5
        xLhcRwWIj6rSeY2KS1FSEqLtemhIeNnql9yWlmIFU2k2UUxhbjnGPL5SgJg77ZUU49JXUcxo
        rQNj6i5dRcyS6znJ2L51YkxHUzXF/HJ/CmN6+i8i5uvZMcTo7m/7wJc1VZkQeyHnFsHqbCMi
        Vtc7TbLNxtMU21exQLBV/ftZe/4x9myLEbHmlrsEO2joFbGzzYH7Vh2W7EzkU45m8prI976Q
        JI+ey0XqooDjA0s38RzUAPnIRwz02/DIMUTkI4lYTncgKHPNkO4AQW+AjuEJys1SmgH75NAy
        i5dZBotWP7fsR3PQV/4cd7OcDgZ7hQm5LX70Fphv3eiWKToCjO2dhJv96Who+L56pSJO55LQ
        ajwpjCCFirwpQmAFWK62Ijf70FFQ1t+NC/pqGK6fFnn58Y1LSGB/+OaPXz0eGThfdnj0tVB/
        rXBlLaDPIDD/1eV5VCAomCjzZESDucboqbob9H29ImG6g1DS/g8l6G9A6c0GTNB9oXBhEvNO
        ba3y8gbQDTeS3g1mnzzxbMPCuYILSDhuA4KnN34WfYeC9P/dUf+/dgIHgWW6EndbcDoUzO2R
        gvwmlBQ981jegZy8UkLgYCg5My4yIJERreHV2tQkXrtNHaXisyK0XKo2Q5UUkZCW2oxWPmfY
        R1Y07pyJ6EGYGPWg9cvpE431dhRAqNJUvNJf2vXDHCeXJnLZJ3hNWrwmI4XX9iCFmFC+Lh1I
        auTkdBKXzh/jeTWv8UYxsU9ADvaVpWYJxo6Qc4lQuxht+3LXaG/Wkc8OZKgkMQrJjk33ih0/
        kavW0U4yMm3vg3e7T55tJhcv4yd8+qZDnMWNd9KZnbNrP33rofH9y0Wb9bJ1meW2kvnND0qt
        tzcN1WafEm2cC4oOjH9U3cSfittlMPsalG3Be7NTR9IP6e3K0dNkzZo4NIFd/PHDBMWLqYTO
        OmyfQy1Ptjhm4ibnR8rx2E+u/M23FOHXMv+UfR6bH2IMH/x9R6zllRfbZQtLW3fHqH/rct3u
        /FhV6bd+PCZ8//Ww1x6ed7j6Xz18qw43xRY8ywgNVFm5Q922se1PoyazDMcHQ+L3tA0Quf55
        dfforqa7oCS0ydzWMFyj5f4FrdjEVhcEAAA=
X-CMS-RootMailID: 20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc
References: <YfkBQNBEPrAJ9jKw@smile.fi.intel.com>
        <20220201040044.1528568-1-maninder1.s@samsung.com>
        <CGME20220201040100epcas5p180ef094058fc9c76b4b94d9d673fc5fc@epcms5p7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1497478_934560393.1643711063682
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"

Hi,


>> ..
>> 
>> [   19.276023] Call trace:
>> [   19.276277]  0xffff800000ec0000+0x28 [crash]
>> [   19.276567]  0xffff800000ec0000+0x58 [crash]
>> [   19.276727]  0xffff800000ec0000+0x74 [crash]
>> [   19.276866]  0xffff8000080127d0
>> [   19.276978]  0xffff80000812d95c
>> [   19.277085]  0xffff80000812f554
 
>> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
>> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
 
> Who is (are) the author(s)?

Both are authors (Maninder and Vaneet).

Sorry, forgot to use below signature.

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Thanks,
Maninder Singh
------=_Part_1497478_934560393.1643711063682
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rcptInfo.txt"
Content-Transfer-Encoding: base64

DQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIFN1YmplY3QgICAgOiBSZTogW1BBVENIIDEvMV0g
a2FsbHN5bXM6IHByaW50IG1vZHVsZSBuYW1lIGluICVwcy9TIGNhc2Ugd2hlbiBLQUxMU1lNUyBp
cyBkaXNhYmxlZA0KICAgICAgRnJvbSAgICAgICA6IG51bGwNCiAgICAgIFNlbnQgRGF0ZSAgOiAy
MDIyLTAyLTAxIDE1OjE2ICBHTVQrNTozMA0KICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQogICAgICAgICAg
ICAgICAgICBOYW1lICAgICAgICAgICAgICAgIFR5cGUgICAgICAgICAgSm9iIFRpdGxlICAgICAg
ICAgICAgICAgICAgICAgICBEZXB0LiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDb21w
YW55ICAgICAgICAgICAgICAgIA0KICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQogICAgICBNYW5pbmRlciBT
aW5naCAgICAgICAgICAgICAgICAgVE8gICAgICAgICBTdGFmZiBFbmdpbmVlciAgICAgICAgICAg
ICBTeXN0ZW0gUy9XIEdyb3VwIC9TUkktRGVsaGkgICAgICAgICAgICAgICBTYW1zdW5nwqBFbGVj
dHJvbmljc8KgDQogICAgICBwbWxhZGVrQHN1c2UuY29tICAgICAgICAgICAgICAgQ0MNCiAgICAg
IHJvc3RlZHRAZ29vZG1pcy5vcmcgICAgICAgICAgICBDQw0KICAgICAgc2Vub3poYXRza3lAY2hy
b21pdW0ub3JnICAgICAgIENDDQogICAgICBsaW51eEByYXNtdXN2aWxsZW1vZXMuZGsgICAgICAg
Q0MNCiAgICAgIGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmcgICAgICBDQw0KICAgICAgd2FuZ2tl
ZmVuZy53YW5nQGh1YXdlaS5jb20gICAgIENDDQogICAgICBtYmVuZXNAc3VzZS5jeiAgICAgICAg
ICAgICAgICAgQ0MNCiAgICAgIHN3Ym95ZEBjaHJvbWl1bS5vcmcgICAgICAgICAgICBDQw0KICAg
ICAgb2plZGFAa2VybmVsLm9yZyAgICAgICAgICAgICAgIENDDQogICAgICBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnICAgQ0MNCiAgICAgIHdpbGxAa2VybmVsLm9yZyAgICAgICAgICAgICAg
ICBDQw0KICAgICAgY2F0YWxpbi5tYXJpbmFzQGFybS5jb20gICAgICAgIENDDQogICAgICBWYW5l
ZXQgTmFyYW5nICAgICAgICAgICAgICAgICAgQ0MgICAgICAgICBBc3NvY2lhdGUgQXJjaGl0ZWN0
ICAgICAgICBTeXN0ZW0gUy9XIEdyb3VwIC9TUkktRGVsaGkgICAgICAgICAgICAgICBTYW1zdW5n
IEVsZWN0cm9uaWNzDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg==

------=_Part_1497478_934560393.1643711063682--
