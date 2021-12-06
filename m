Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED1646A966
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350535AbhLFVRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:17:38 -0500
Received: from mout.gmx.net ([212.227.15.18]:43815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350451AbhLFVRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638825227;
        bh=V0fUI45FiryQycNH/5CW5LYGUI3v4pzRgZyF9sz1Mqc=;
        h=X-UI-Sender-Class:Date:From:Subject:To;
        b=kg9sGV6X5Jlaeqb2IzV9w9EuRq9hFKY1nzDAPU2cJjJZ61w8WJACfGM8ECx4HKggj
         xxtg2ddWXRbNUTHSb4ucm9fxyXWla9cceDKI5Zwh9q7HREGNU6yLj0nD2Fs1mTjYz4
         cFePKxobsn3JWC5EMC0orDQXnLAVZzS/vJg8EnEc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.100.20] ([46.142.35.26]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My32L-1mdbq13s0V-00zSeg for
 <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 22:13:46 +0100
Message-ID: <48190f69-169c-8e1f-cfdd-f8fe57dde084@gmx.de>
Date:   Mon, 6 Dec 2021 22:13:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Ronald Warsow <rwarsow@gmx.de>
Subject: Re: [PATCH 5.15 000/207] 5.15.7-rc1 review
Content-Language: de-DE
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:INRUZmbNbJXwCgBM3n8KO7ec/bsmIeVUQfE/BYziTRPnPxMArNe
 lk8TYgmJ5E/BXIGQwsS1tw5On+jIjbUfcpAriBTYODPUQC1VVGoP8sNUrnaFv3HPGdR93ts
 ncW0u02pP12A/Lc9hgy7p7p+CPF8wF+Hr98ROmDVV5o2yVbngIVT4smA9cxTeTFKrmYqyIX
 oZ87uEgMv+j7bQkR5qJrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LfbuRZMlybc=:PSpB6R2SRdSed3oE2SGPMT
 7eSNTe7G5fioKTbukd1w64Yw8mSIuI8St/BZLdC5ffmm1t9VwBc/TajLCTFohih/ZpIcjWiuf
 GpGaXM+prxphBx5rMDROz6tzm4tuhdDHZp0WCsT5Syo8f2OneS1Kw4gAKmjh9Bc2VCmKsY/IA
 LIwBisU07AVykoC7JBYX1OJYg+lWwXA9Af0hyuwUO1wyFFwCfXbOqVccOXBASL4lvf3JpvD3h
 azlrxUl9CsZZfoTK0/WyYIZ8quHbFyo8Xcu9SW+pXFZXT9/2MJ01P/VB3e9iqqgTKOnxcvPLY
 qUbFYxrD9XbmFdViTph3LZ2GZR2EZ4barGOwJQT0vp1gqOuhKSC7EX8AXZhSsZ+Nwp4Vu0KaC
 4GiwZq0AbRUmJfcN+JelN3thZaCBXxdX93HPIBqH7U44SmIUaye1232SkYV83fgMaiARn+xbz
 aFf+m1h/yGQbjSg/U9C8eMBEumRPmQhi0IzlEUaVNGzz4p8WsTwwjORb0rt9e34zO39cs5+j6
 FWoqktlgOaBoNLhYY2BPh7o7gcE1e3ltqqOIgczg+mmqcop2vKYImnOUY+5Sb/wOEMaYlDsKS
 6bxnVzTVAnzlMhBD4QKzWb1sKxHb87SBWC1gVxvY/Z2PzRfEm3roGuIxp/v8d2jmFDRV6+p1h
 mYc7/dqTh0yHMn2ESX2bBP/XgdJu+DwwTS6Fja4XNEkx6qJfjaUhMhaS4U1uVs56DG5Qc5ICp
 vu24MzRaUhHn112wdR5p0mgOrD2DqpNHIp8hFbf+09HYMviYKIJO4PnRugOC6TscuTSYmh/6u
 i4uI30dne2VFIeOdjDlKx/D3NMMdFsV7dFJCrs3S8OTvYiCk3leGOrGlfHrNBk1QySb7LyHXB
 fBqA2v3c/+4L0m3AQ+EU9Bu6xuBhW6PTwX3FP8Wa5mUCMwSWQywFjdnFrZiF4MJzqBwiEpJxi
 DVAw5XUV6KrwSKXNsiNnuzMAdiwXda1Mss1I0+WyWYXffOm0C39pNjeenBZRXJvM4fLhWZ1ro
 rOIm1K7kpkhA3BRRlm2WkeDP5UZvUTsGn5a6BXssdVPgKxlqQb3bP/cgZgw2f3J/zKJOGtAam
 NotBctUCZ7iu7g=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
5.15.7-rc1 successfully compiled, booted and suspended on an x86_64
(Intel i5-11400, Fedora 35)

Tested-by: Ronald Warsow <rwarsow@gmx.de>

thanks
---

Ronald
