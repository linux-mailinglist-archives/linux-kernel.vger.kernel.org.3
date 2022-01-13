Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E711148D4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiAMJHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:07:23 -0500
Received: from asav21.altibox.net ([109.247.116.8]:54480 "EHLO
        asav21.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiAMJHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:07:22 -0500
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jan 2022 04:07:21 EST
Received: from canardo.mork.no (207.51-175-193.customer.lyse.net [51.175.193.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bmork@altiboxmail.no)
        by asav21.altibox.net (Postfix) with ESMTPSA id 2359A80146;
        Thu, 13 Jan 2022 09:58:25 +0100 (CET)
Received: from miraculix.mork.no ([IPv6:2a01:799:c9f:8602:8cd5:a7b0:d07:d516])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id 20D8wODU374231
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 13 Jan 2022 09:58:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1642064304; bh=yl54sanNDUWMM+AQIqqbrLuI+gS3uSjsOTBkYc4iasQ=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=EVIM26CSPcEzIGBEUXhAABRkH+4CGL3T01Kx8lanZ+U3coHcbP6cnhsik96ZOgQ00
         QQDxfFrVYJhBw+Gb1eVMsIj18u8Ej1cII98XBrVHJwYQsBZgITVxXuM9Y6Uz6w9Erz
         jm9OFa5LUKFddcPQI6ckzgl61yhpwpQdpzH7ax+U=
Received: from bjorn by miraculix.mork.no with local (Exim 4.94.2)
        (envelope-from <bjorn@mork.no>)
        id 1n7vw8-001bMp-Et; Thu, 13 Jan 2022 09:58:24 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     linux-usb@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qmi_wwan: add ZTE MF286D modem 19d2:1485
Organization: m
References: <20220111221132.14586-1-paweldembicki@gmail.com>
Date:   Thu, 13 Jan 2022 09:58:24 +0100
In-Reply-To: <20220111221132.14586-1-paweldembicki@gmail.com> (Pawel
        Dembicki's message of "Tue, 11 Jan 2022 23:11:32 +0100")
Message-ID: <871r1cxb9r.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.3 at canardo
X-Virus-Status: Clean
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ZLv5Z0zb c=1 sm=1 tr=0
        a=XJwvrae2Z7BQDql8RrqA4w==:117 a=XJwvrae2Z7BQDql8RrqA4w==:17
        a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=DghFqjY3_ZEA:10 a=M51BFTxLslgA:10
        a=rWqaOqVXLpn30FgQbZwA:9 a=QEXdDO2ut3YA:10 a=3la3ztWH3XQaG4dFsChN:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Bj=C3=B8rn Mork <bjorn@mork.no>
