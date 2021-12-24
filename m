Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569B347EBFB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351485AbhLXGNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:13:20 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:59941 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351418AbhLXGNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:13:19 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211224061317epoutp03a7757819548992be958567decc98b1a7~DnCrmOZzz2591525915epoutp03K
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 06:13:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211224061317epoutp03a7757819548992be958567decc98b1a7~DnCrmOZzz2591525915epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1640326397;
        bh=oQ0nNoD3mMNeRCEcuxyUI3C8qcrkMxbsxFh07JE6F7I=;
        h=To:Cc:From:Subject:Date:References:From;
        b=m8gLlIOH/P0UTNEWIIZ6Qs0wFExsG5hltRKqdEfMjFowlRFr0jJ9vybnzsdBebiCr
         Xy1rAPhtep1EpBYqz+/BM8gCYhPjT7W+kCTbikeC5Raykj6/DhWW8HIxBfborYna7N
         EQhvNXdvPl82s9tDSpVGqUUtEhfi6nAql0ybHeKQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211224061316epcas1p12ffa9ba7400f80e7b5e1d5f3d1bd50be~DnCrNTpTe2252422524epcas1p1R;
        Fri, 24 Dec 2021 06:13:16 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.234]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JKxZG684rz4x9Ps; Fri, 24 Dec
        2021 06:13:10 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.76.64085.6F465C16; Fri, 24 Dec 2021 15:13:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211224061310epcas1p310f2caefe84f949a6764d2b0868611dd~DnClRRhst0503205032epcas1p3H;
        Fri, 24 Dec 2021 06:13:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211224061310epsmtrp1158d6c60136bd121f52e4951bcc2373b~DnClRTeI02597325973epsmtrp1H;
        Fri, 24 Dec 2021 06:13:10 +0000 (GMT)
X-AuditID: b6c32a35-9c3ff7000000fa55-b5-61c564f649c1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.72.08738.6F465C16; Fri, 24 Dec 2021 15:13:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211224061310epsmtip226fe95c870ebe04f7063bff662a8717b~DnClEqESg0304203042epsmtip2J;
        Fri, 24 Dec 2021 06:13:10 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        chanwoo@kernel.org,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.17
Organization: Samsung Electronics
Message-ID: <bbf20e51-ffff-4b19-478e-739a0a011218@samsung.com>
Date:   Fri, 24 Dec 2021 15:36:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTV/dbytFEg/lPLSwm3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAlqhsm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6XUgpScAtMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IwNEyewFTxjr1h6NKyB
        cRdbFyMHh4SAicTaJ+xdjFwcQgI7GCXOH1oN5XxilHi57y8LhPOZUWJX3wwWmI5pN0Ih4rsY
        JWZ83cfYxcgJ5LxnlLhxRRTEFhHQkHh59BYLiM0scIRR4udWLhCbTUBLYv+LG2wgtrCApsT0
        8zPYQWx+AUWJqz8eg83hFbCT+Lr1MCuIzSKgKnF46hcmEFtUIEzi5LYWqBpBiZMzn0DNF5e4
        9WQ+E4QtL7H97RxmkOMkBN6yS9xZdhKsQULARWLjle8sELawxKvjW9ghbCmJl/1t7BANyxgl
        fk3uZIJw1gP9P6uTGaLKWGL/0slMIO8zA529fpc+RFhRYufvuYwQm/kk3n3tYYWEEK9ER5sQ
        RImyxOUHd5kgbEmJxe2dbBC2h8SDza/YJjAqzkLyzywk/8xC8s8shMULGFlWMYqlFhTnpqcW
        GxYYwuM6OT93EyM4RWqZ7mCc+PaD3iFGJg7GQ4wSHMxKIryeq44kCvGmJFZWpRblxxeV5qQW
        H2I0BYbwRGYp0eR8YJLOK4k3NLE0MDEzMjaxMDQzVBLnfeE/PVFIID2xJDU7NbUgtQimj4mD
        U6qBSXJlCXfUnLAusUvme4+92CfjLuPIZc6qMPtOYOvM1hwu2dz2xXqrL81+uDdV/oyJsMsX
        36IC1btxIW4Ve3dzm6626Xqhne08t+uywM6+kxHGllVsh7PXfM/oq8y/YvS2pIs3IWmt4v8Q
        du3iGdpzVx/mib1dG5vebXqq8KrNNjM270N76q9zX9qu9MxrwXNnvTcfV63c8Hzpthsie3Yf
        0WXgmGRosPKe3FuRikqp8i2MifzJ64VlVwtI/jp74GrEod91dUe+5dl77/z7oaU9sPTaskei
        f6fsefrgpOOmtwdb/fou7/0/IyAuM/qOTgfP2/Mlks8nHakq3ptuqvvUx0Dscm759o+Wt1kP
        r7/3UYmlOCPRUIu5qDgRAO0PikkaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSvO63lKOJBhuXyllMvHGFxeL6l+es
        Fs2L17NZXN41h83iduMKNgdWj02rOtk89s9dw+7Rt2UVo8fnTXIBLFFcNimpOZllqUX6dglc
        GRsmTmAreMZesfRoWAPjLrYuRg4OCQETiWk3QrsYuTiEBHYwSjzYexUozgkUl5SYdvEoM0SN
        sMThw8UQNW8ZJd61nWIFqRER0JB4efQWC0iCWeAIo8TmYy2MIAk2AS2J/S9ugA0SFtCUmH5+
        BjuIzS+gKHH1x2OwGl4BO4mvWw+DDWIRUJU4PPULE4gtKhAmsXPJYyaIGkGJkzOfsIDYzALq
        En/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKj4CwkLbOQtMxC0jILScsCRpZVjJKpBcW56bnFhgVG
        eanlesWJucWleel6yfm5mxjBwa+ltYNxz6oPeocYmTgYDzFKcDArifB6rjqSKMSbklhZlVqU
        H19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTpM/94Ixv8393dLu6BOzM
        iCxc92WtfazG1ye7Ai9JmnfnvP3UlfnFzLx707yA8OMC6xQuXwm8r7tTXravkWuvxpaZFs/c
        z15ZJ/aILWOGorHQx46ElMVKcrwn1JXe/m+yupRicifn7jyrzgnd50P4LL2+Vpftub7+5EeZ
        xRWdF4ImN85TmNQ+oXiZ+ufb1dtDnaZWt8jwzInsZ3/RnZFZ+iaA530CD6Ngc4VZxvab4Us+
        VSziW/P925pf5u/2rts+5bq3eYte99TWM0rq9zUbzlx9sy/LZbf2hpOHjm1b3JWdki615Z7k
        U4GaaOPac1rWITtrc8IkpuwI9znqd+SX5UappQd9JRs0eoTrbjkpsRRnJBpqMRcVJwIAZ4MJ
        4+0CAAA=
X-CMS-MailID: 20211224061310epcas1p310f2caefe84f949a6764d2b0868611dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211224061310epcas1p310f2caefe84f949a6764d2b0868611dd
References: <CGME20211224061310epcas1p310f2caefe84f949a6764d2b0868611dd@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.17. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.17

for you to fetch changes up to 2da3db7f498d8b6137566b4869d289938b69de13:

  extcon: Deduplicate code in extcon_set_state_sync() (2021-12-24 15:27:52 +0900)

----------------------------------------------------------------
Alexander Stein (1):
      extcon: Deduplicate code in extcon_set_state_sync()

Randy Dunlap (1):
      extcon: usb-gpio: fix a non-kernel-doc comment

 drivers/extcon/extcon-usb-gpio.c |  2 +-
 drivers/extcon/extcon.c          | 14 +-------------
 2 files changed, 2 insertions(+), 14 deletions(-)
