Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79CE49C62F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiAZJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:21:39 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41546 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbiAZJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:21:37 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220126092136euoutp0114e3febfd2f689bcf0752688e9fa79f1~Nx5hTNsL70166501665euoutp01L
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:21:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220126092136euoutp0114e3febfd2f689bcf0752688e9fa79f1~Nx5hTNsL70166501665euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643188896;
        bh=FPzpBP6nJNWCXtxCcT6xJXmWCA6rvKk9U6lL/nJB2EI=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=IkbdMx0KElJbM1Z6GwCZEYtfgKREmGHGGy5auc4/U0535+VIENKYr6wpTaroP7J6X
         8zuA4n5A4b1vgpet8fOvIwc7EaNvfj9qyh16go0CFYffAtst1IIwc8RGNDeVLo/z+C
         o3Ol+cfpZvqaPVlnbHl9wRJMYqUfbpEOYYJGrZFk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220126092135eucas1p1c3d505b503cbd0207b0fe66dab8a2935~Nx5g7SWJk0449204492eucas1p1G;
        Wed, 26 Jan 2022 09:21:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 13.10.10009.F9211F16; Wed, 26
        Jan 2022 09:21:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220126092135eucas1p17003e792756fa2420bb90147093a3ab3~Nx5gcdI1f0518105181eucas1p17;
        Wed, 26 Jan 2022 09:21:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220126092135eusmtrp15c821d1363b93c47c1eb6eb9e85b65a6~Nx5gbDGw31737217372eusmtrp1v;
        Wed, 26 Jan 2022 09:21:35 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-7c-61f1129f8c48
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B6.34.09522.E9211F16; Wed, 26
        Jan 2022 09:21:34 +0000 (GMT)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220126092134eusmtip17721ac7a373325afbce9d9c84fc9e32c~Nx5fbHaaN2733627336eusmtip1I;
        Wed, 26 Jan 2022 09:21:34 +0000 (GMT)
Message-ID: <bccd3ad0-7862-ef3b-246c-71463baaca52@samsung.com>
Date:   Wed, 26 Jan 2022 10:21:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v5 00/16] Add support for Tesla Full Self-Driving (FSD)
 SoC
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <063601d81281$5492d620$fdb88260$@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVCTdRy/356XPVs3fBwY36OSbkUGl1MO4n6Kt7PEespe/9POwid8BBIG
        t4lmL4aUGjZsAoYtZUgpusMTHnEi7wKKsAvyqk1QfAkCIwfNmYcbsNwevPjv8/l+P5/v230Z
        Qt1PRTGZ+i2CQc9naWglab/4oG+xVe3hlxZeWohvlttpPF18UY4njpkQtnb2UrjWPSnDpVNV
        MiwOOSnsMV2n8K8Nh2h8sK9FhntcXhpXnrknx7uaO+V4xllL4iHXFL1yHlddXo04v68YcZb8
        IpoTbYU0d83ZRHOnf/qC++1SAcXtq7MhzisufEfxnnLFRiErc6tgWKLboMxwDpykcyvJjwdv
        XaDz0XFiL1IwwCaC9cwg2ouUjJo9juDI6HlSIvcQnPxrXC4RLwK354bskeUf8ylCSlQhGGgT
        Zy0eBOXTI3RQpWJ1cPSgI9SEZGNg5PaPpBSfD93fDz/EDLOA/RBMX60KhsPZd2HosjckJ9hI
        GBi2hppFsNUIRivWBusT7G4ZNN6qDdWn2XgourAPBbGCXQ4FJfdpyRwNZ92HQtMBe1YBl8f6
        ZzdNgaHTjZSEw2Gsq04u4SfBUWIiJcOXCEyNV+USMSO40VWBJFUyXOv10cGxCTYWTjUsCUJg
        XwJLPynBMLjini/NEAbF9jJCCqvg691qqcaz4LeVzR4xCr4ZDpBmpLHMuYplzvqWOdtY/m9b
        gUgbihTyjNnpgjFeL2zTGvlsY54+XZuWky2ih9/nmOm6W48Oj3m07UjGoHYEDKGJUAXWTPBq
        1UZ++yeCISfVkJclGNvREwypiVSlZdbwajad3yJsFoRcwfAoK2MUUfky5WOvoqI7rY8Hwo+k
        LPo9jq3Rd2c8v3beiQ9y7yb+3fHpfsFd17Y8IaLVeXPDZ0TrlK2yeVXCD/bi1fW+uGOblIEk
        e2tNx2qfM1a7p8iAt+pf6WyxOipNPq3N03Gl6f1NCbd1n2/uG51cdjh58E3mhWXPpR4o2G74
        ri/BuBN+fmbHy46JpXvO3/nW0kU15VEP1H/OmM+JOtXTbTi3PslbeDU6Y/0vpeayHvy2KJ5w
        qRL/9ff0/pGyopndFUOWOMfXOH1PJVHbwnpKd9RPX5dz0VXuBX5Xt1y9KJD6Ysxr2e7XG1wj
        NZM56W+kjWv8LZ3nlLp1yYth/K14k3j0wEex63eu05DGDD4+jjAY+f8A0hIi9ewDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xu7rzhD4mGhy4a2rxYN42Nou/k46x
        W7xf1sNoMf/IOVaLjW9/MFlM+bOcyWLT42usFh977rFaXN41h81ixvl9TBanrn9ms1i09Qu7
        ReveI+wW/65tZLF4fP0PmwO/x5p5axg9fv+axOgxq6GXzWPTqk42jzvX9rB5bF5S73HlRBOr
        R9+WVYwenzfJBXBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZk
        lqUW6dsl6GVcu7WWrWARS8Xdh0fZGhhXMHcxcnJICJhIfJiwHsjm4hASWMoosfhKB0sXIwdQ
        QkpifosSRI2wxJ9rXWwQNe8ZJfYvnM4IkuAVsJNYOuM02CAWAVWJZy8Ws0DEBSVOznwCZosK
        JEk0HOtmA7GFBQIlHl/8DFbPLCAucevJfCaQoSICaxglVr05wgSRaGGSeLkzEGLbd0aJHWd+
        gnWwCRhK9B7tA9vMKWAl0TT5GxvIpcwC6hLr5wlB9MpLbH87h3kCo9AsJHfMQrJvFkLHLCQd
        CxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG+rZjPzfvYJz36qPeIUYmDsZDjBIczEoi
        vP+93ycK8aYkVlalFuXHF5XmpBYfYjQFhsVEZinR5HxgqskriTc0MzA1NDGzNDC1NDNWEuf1
        LOhIFBJITyxJzU5NLUgtgulj4uCUamBatH6nU8pbT/bos6FX9vydtWzXnymKPY+0lZ9qnvwy
        0YbVIcfn6XUhCbefv5jzg1jXfHn+LnBzQvu0La+evb/utsKhzDQ/7GuiilZeL/9F8fnu2j/8
        Fk1S3aw2TUhFjqXgxYeJX2ee1DrNeiXEpThRpmy2ecumxW83rFENfbt2rfSy/U0L8i1etdp/
        /jzVe+Y5R7vHsc6L1+dGha+eLrftvxhLRU6AdrSx8tLe107WbtJ75G64NeXHXM/7qaTKUZOj
        VhlodNhPt2PnnQUttyW3We6eXJPZ/rH2hOkhd6esXacaTKOyJi8+7+7I5bPgn0Ig67v5D7kW
        lO9PYInIbC9ba7fjxzzxPfc/eHifE2ZQYinOSDTUYi4qTgQA9g850H0DAAA=
X-CMS-MailID: 20220126092135eucas1p17003e792756fa2420bb90147093a3ab3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b
References: <CGME20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b@epcas5p2.samsung.com>
        <20220124141644.71052-1-alim.akhtar@samsung.com>
        <d9682f16-13b7-b6dc-5afd-b2d319143de5@canonical.com>
        <063601d81281$5492d620$fdb88260$@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26.01.2022 07:52, Alim Akhtar wrote:
>>
>> Thanks, applied DTS/soc and pinctrl patches.
>>
> Thanks Krzysztof
> 
>> I expect Sylwester will pick up the clock ones. Otherwise please let me know
>> to pick it up as well.
>>
> Hi Sylwester, hope you will be taking clock changes, or let Krzysztof know otherwise.
> Thanks

Krzysztof, can you also take the clk patches through your tree?
If you prefer to avoid it I will create a topic branch with the
clk headers and DT bindings documentation.


-- 
Regards,
Sylwester
