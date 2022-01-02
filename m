Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA04482D3C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 00:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiABXdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 18:33:07 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:38444 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiABXc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 18:32:56 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E73999200B4; Mon,  3 Jan 2022 00:24:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E046592009B;
        Sun,  2 Jan 2022 23:24:03 +0000 (GMT)
Date:   Sun, 2 Jan 2022 23:24:03 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jean Delvare <jdelvare@suse.com>
cc:     linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH 0/2] firmware: dmi: Avoid (some) empty names in kernel
 log
Message-ID: <alpine.DEB.2.21.2201020127140.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Resending as this has gone into void.  Original patches still apply in 
their original form at the same respective lines.

 I've noticed one of my systems shows this output in the kernel log:

Legacy DMI 2.0 present.
DMI:  /i430HX, BIOS 4.51 PG 05/13/98

which leaves something to desire.  While the contents of /sys/firmware/dmi 
remain the main source of DMI data, along with output from `dmidecode', 
the summary from the kernel log is often readily available with various 
reports, making it a point of easy reference.  Therefore I think empty 
names are best avoided if possible.

 The system in question is a Tyan Tomcat IV S1564D mainboard, which has 
its System Information all empty, not unreasonably as it was sold as a 
bare board for field integration rather that a complete system.  It does 
have the manufacturer correctly recorded with Base Board Information 
though.

 I have therefore made this mini patch series, with 2/2 printing the board 
manufacturer if none has been given for the system, and including 1/2 as 
well to prevent a trailing slash with an empty board name, following my 
observation made with an unrelated issue where the reporter included a log 
with just "/" shown as the system name.

 See individual change descriptions for further details.

 Please apply.

  Maciej
