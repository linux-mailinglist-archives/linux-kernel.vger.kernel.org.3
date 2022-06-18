Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845E5550304
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 07:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiFRFik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 01:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbiFRFi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:38:28 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D152848392
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 22:38:25 -0700 (PDT)
Date:   Sat, 18 Jun 2022 05:38:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1655530703; x=1655789903;
        bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=tSyuifwbDS+nq+djQ6UlupBBlFH3ObNvyWiXS6k/EK1lYGEIxBeaDM7EN/IfpCs2Q
         n/nQgJOkiGJgQYHY4ECCKEzAs6QO44mcxo0XHN3e0IrjFGXfTr0B83F97Pm3yRf+uA
         ACYvdGGWr61XJ13gobn0YOffxqjoQxd1wHzs18t4SudiP15b6PJluRqWsQFQfOg0mk
         D/UG0sUVnhKQkEK5zgT2ixRnbFDvGXvmPC2VyInN+ckNJDWCRQbUc2+fhHafNeP6KO
         S+pdhmDvNuPDsQp81YUWx3XO7JPDpT7yfE+LFYRwg/+sW0ekGz534YeGtWm9s1tbbN
         8LmbCWNu/vitQ==
To:     Souptick Joarder <jrdr.linux@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com, Roman.Li@amd.com,
        shenshih@amd.com, Wayne.Lin@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kernel test robot <lkp@intel.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: Remove unused variable 'abo'
Message-ID: <_2lEhqJcf7dWZ9gxUFTqACIgfM7O6Mnus7HdamgrIT3zwLBiP7Quzy9MLnuFk5EYQAobBEa9UwI-1SSgEhmsncVEsKai10xWlJk8LvRs-W0=@emersion.fr>
In-Reply-To: <20220618015642.5958-1-jrdr.linux@gmail.com>
References: <20220618015642.5958-1-jrdr.linux@gmail.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Simon Ser <contact@emersion.fr>
