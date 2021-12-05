Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55329468DC9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbhLEXAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:00:02 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50499 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbhLEW76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:59:58 -0500
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0F12D8364E;
        Mon,  6 Dec 2021 11:56:29 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1638744989;
        bh=hPunGPMRvBOHcu02PiTcqRXQB+5yCRzdb3bxMRQqhQU=;
        h=From:To:Cc:Subject:Date;
        b=PJhYH3o7LUQOT3+TFwX+OFWvcAzv/yKZwvxylRPJotfPqV+5cLaHYGFyWI1cYD3AK
         m/6rWyLzP/UM++16PxAU+9CTHbUVs9xE06j+XuCOQk/njhJGdLTBeeYU5lCFi1I0Lh
         DoNpzMpBu3NR2ubNGwZKOH/ougV+kwQ8LjH85yqtWwLvSbhLQgkFTVrpO6BwzquNWa
         wFmY84FtpqXhOf9UsqVWCBBLlQDNEQCvoCFbBkFHaTdSphWS4AUo2LKNklV7YJUC0i
         U/BYqtdg4TMTAMDXnFqkWBzs9kxQRjqlsVv8dQnjw1CMWJXa3tGTwrMnYoojvazvg8
         HpYTBPxprfRkQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B61ad439c0000>; Mon, 06 Dec 2021 11:56:28 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id D45DC13ECA6;
        Mon,  6 Dec 2021 11:56:28 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id CE13C2A02A6; Mon,  6 Dec 2021 11:56:28 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        kabel@kernel.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/2] arm/arm64: dts: Enable more network hardware
Date:   Mon,  6 Dec 2021 11:56:16 +1300
Message-Id: <20211205225618.1565909-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=XOZOtjpE c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IOMw9HtfNCkA:10 a=qo0w0_OOfvo38LgcXCYA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables the Switch on the CN9130-CRB. The changes are based o=
n the
Marvell SDK.

Note that if anyone tries out the SFP+ port on a complete CRB shipped fro=
m
Marvell the chassis prevents the ejector from working so the SFP will get
stuck. Taking the board out of the chassis allows the SFP to be
insterted/removed.

Chris Packham (2):
  arm/arm64: dts: Enable CP0 GPIOs for CN9130-CRB
  arm/arm64: dts: Add MV88E6393X to CN9130-CRB device tree

 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 140 ++++++++++++++++++++
 1 file changed, 140 insertions(+)

--=20
2.34.1

