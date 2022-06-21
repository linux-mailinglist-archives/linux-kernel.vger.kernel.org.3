Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBFF5538A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351935AbiFURPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiFURPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:15:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA0D2A73C;
        Tue, 21 Jun 2022 10:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A007DB81A8C;
        Tue, 21 Jun 2022 17:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E560EC3411C;
        Tue, 21 Jun 2022 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655831721;
        bh=Cv2jhgl2RqU9z4AA4Ivxf+DUW488m0ULCBWrVcbwDiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lxmPLgunPScWcwtiTFiaI3zOIlYOWfRJNyNTRdfPyLFg7/qqH9kEva0rDNddbq4Pj
         KlQ5+vJy4cTXaytSWr/DYHyL7OV7e7QeyuCrzHgpGxhqSIi4eyyN+Hy6hJmpEVN5XJ
         EO36wT4AR1V4QMUuu5IgIuETQ0/+kkCLnTy2uAhcRkIyAEtH+1HKNUhoTrK7V5vbD5
         nz/DBnrwdJiTlwluscrrp82feWIRMAVVyEBjRT72yOsoWgOM0rSK7p2Z6HCiieSZBW
         XYVRYcQ/j5MdrJ5MXc6S1xc6ehy0ME1dAhXGEArsQ417gH4aeroD6tuRCC5UsDGLyT
         ydcU7/H36xtqA==
Date:   Tue, 21 Jun 2022 12:15:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lizhi Hou <lizhi.hou@xilinx.com>
Subject: Re: [PATCH v3 2/5] of: remove __of_node_dup() allocflags parameter
Message-ID: <20220621171517.GA1315139@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620104123.341054-3-clement.leger@bootlin.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 12:41:20PM +0200, Clément Léger wrote:
> The alloclags are always set to GFP_KERNEL so remove this specific flag.
> Moreover, this function is going to be based on one that does not
> provides passing gfp flags, so be prepared for this.

s/alloclags/allocflags/

s/provides passing/supports passing/
