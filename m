Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711F3466E96
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377788AbhLCAoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:06 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:53562 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhLCAoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:05 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswcymQfSK; Fri, 03 Dec 2021 01:40:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492040; bh=wmeqoxd56I26/Bfnmcs6KN+aez5kRcCVkb0VoadpCeE=;
        h=From:To:Subject:Date:MIME-Version;
        b=ULsEbOqMEGDGgk95GhF7x8irAcCQi1kRlt3UzdBb06frPbvZ7HWUskv/gvFUTHp/H
         0D8zz31wnpnP2k0OHqSX3nXngBpkzhFGG/9wr2F2WjGTvh1Oqe/ch3rfTpJJRGN0iX
         D/e7PIkeQMcBBEakQ101yrim6l0oVQUl0kcyzOHjBW5AdljOsFH8sJJ7czdgV1ONLK
         KbzDEvyilhV9DWTK8rHiXfZ4t477mZETjtd0a1VI6e9EaI6ahQ9JjZW7HnJNBbVeWp
         4n1XW/tzg3+jDMAZVQ0h3NDbbzHQLGT0heG7bOl/V07nClQLeZ0ETB42IR3AUMpPve
         t3D/xThGOS98A==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 00/17] Drop useless fsl,imx- compatible strings
Date:   Fri,  3 Dec 2021 01:40:22 +0100
Message-Id: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHg6RmiNu+1Xz6+j/1qe4v/lhqAFedvtVtG1hqml9gdfTi4Pj/rOOlcM+AVtJDqJ0sQDbjhXXsUdH4aSBN2oB0/hy7+weWhNwQyVrmHYfrCDFRnJnFGw
 CgJO/PoVWoRKRC7qeoksWTXv9Vadt+tO/h5OcHcJ3r6jc3hhIWtp9jbv8N24oUKoHK5I/m56lKQJbLt9Uk9ODur3Dk74YqbKDRQvnKvFUdc/iaV+9Mf19flU
 D5WA/iyXEZw5qZl4bJ7n1P6ykv2J/FZ91EpFzS3oc/G5jzo6Fs5OXxQ08MeMU+sisHrgpnUJfWS1s9aqYqY3pTHHLkiPBIo/M4R9L8Gbzbf73dOAB25ZbMwu
 4mTNwjK765PVM9YAwlVO7HUev6+KSfCiGkMg1eRimfacF+X6nzNa91eCUXNXqktTsBszW6iShQWWH8gbXO7rL2u3zr7TB+Zz99wg7Mrp6xTgo9Gy1DOpOqt3
 OCj9pUsk+fvLSAm3ZnItfXYhEvkJ9kcMk6s+8y0cCyonsQt+VjUeIERsxkZZSgUsbMZSGZ3kMZnFe7FdV8Zj2ReqRSfEXRyxKYX+vfJYpHBHPK+WscAz5sZR
 78Y=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset drops the following useless compatible strings:
"fsl,imx-clk32"
"fsl,imx-osc"
"fsl,imx-ckil"
"fsl,imx-ckih1"
"fsl,imx-ckih2"

Giulio Benetti (17):
  ARM: dts: imx1: drop "fsl,imx-clk32"
  ARM: dts: imx25: drop "fsl,imx-osc"
  ARM: dts: imx50: drop "fsl,imx-osc"
  ARM: dts: imx50: drop "fsl,imx-ckil"
  ARM: dts: imx50: drop "fsl,imx-ckih1"
  ARM: dts: imx50: drop "fsl,imx-ckih2"
  ARM: dts: imx51: drop "fsl,imx-osc"
  ARM: dts: imx51: drop "fsl,imx-ckil"
  ARM: dts: imx51: drop "fsl,imx-ckih1"
  ARM: dts: imx51: drop "fsl,imx-ckih2"
  ARM: dts: imx53: drop "fsl,imx-osc"
  ARM: dts: imx53: drop "fsl,imx-ckil"
  ARM: dts: imx53: drop "fsl,imx-ckih1"
  ARM: dts: imx53: drop "fsl,imx-ckih2"
  ARM: dts: imx6qdl: drop "fsl,imx-osc"
  ARM: dts: imx6qdl: drop "fsl,imx-ckil"
  ARM: dts: imx6qdl: drop "fsl,imx-ckih1"

 arch/arm/boot/dts/imx1.dtsi    | 2 +-
 arch/arm/boot/dts/imx25.dtsi   | 2 +-
 arch/arm/boot/dts/imx50.dtsi   | 8 ++++----
 arch/arm/boot/dts/imx51.dtsi   | 8 ++++----
 arch/arm/boot/dts/imx53.dtsi   | 8 ++++----
 arch/arm/boot/dts/imx6qdl.dtsi | 6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.25.1

