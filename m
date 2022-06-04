Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354B853D7E6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 18:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbiFDQka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 12:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiFDQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 12:40:25 -0400
X-Greylist: delayed 2622 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Jun 2022 09:40:20 PDT
Received: from outgoing12.flk.host-h.net (outgoing12.flk.host-h.net [188.40.208.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074E64F9D1;
        Sat,  4 Jun 2022 09:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references
        :content-type; bh=Ouuq/2x8flfBkWWM3iJ0UXEE0GwTm71ML+wgFSoBGq8=; b=QUQtxPrWcbV
        y9Xe9l14+7nxL6BEbvW0LF0VVxswEr1ogHqoYK74WbMMI6ftRnFtMeFXVKa52FIYFMiKMvjwYEFWW
        r9th580LjPjlIL39USAeQqzSZeBQyvzTTdD1Ej7OwqzbUrZWZwnY7X2JrMJaoUnoOolxd2fr96nNL
        AD7bcQA4XoS2/nQJ/u3ER4pPHFI1wO9qEzVpCYS3ON2gXI734B77Bnb2zuDitBhCYzzHNFjZErq+D
        IWSy0ctagp8E4MA7iOujURvLWoH0Q3jV4tTpf/XgGqv+fYW+sVkTLD6F+CRTGeCsqPeo5Zx0GH+5+
        ZJS1KSQjYJKkghSiIxHVP+A==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam3-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1nxW8f-0001N8-7l; Sat, 04 Jun 2022 17:56:35 +0200
Received: from 8ta-249-1-228.telkomadsl.co.za ([102.249.1.228] helo=localhost.localdomain)
        by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1nxW8d-0006Fa-NV; Sat, 04 Jun 2022 17:56:32 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Justin Swartz <justin.swartz@risingedge.co.za>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: usb: fix literal block marker in usbmon verification example
Date:   Sat,  4 Jun 2022 17:54:31 +0200
Message-Id: <20220604155431.23246-1-justin.swartz@risingedge.co.za>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT82YxiG3cFkeaozVsb5Y251PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5cqv
 NIMzTsl2qXZAml/tmiq3wL2Y4F0412ezGCyTUPanTItOOFNNjY132/lViGIyGqLI4OY9HO9H+Fx9
 YIm3grPYonhfr99jXBd3p8VVa7wrtuUNWnipPNRiS8q/FrUUyhjJsJREzyUqebdx9PH+DyXnx8ye
 plRO3sLIqUlSH7OGrAhi2aay48NyXBwK776ImabmLbFYYN3/5dv5lrtQLYZCqSlK5qRCEdvOvbYJ
 im3HHIQnXkm8F0KVRQVUwKh0zQWyZ67BVZNsblNG3e9c5Awq1buObycMKAhCcQU7LIjZWBnaet7l
 8u1IaVoSD7d+Eo3hB7oSHLSzN/CB4wk1cFv1mcInHpUATLx0UN3ao+NXpg1nW4rYJEVR3zSUL4GK
 dNscpwp/WvsW9rkYlRi0DfpKO5QbxpQ97mDfOGVGuYDXzQ6WZJ8UgaMCryZlVIAiHjTVsvdwQtuz
 vJLCXpRXoS3aG/w4HzP8aLtmk5ibSBsf0vPcm60p8kIPTs72y1m7lCGwfqeNO0Vta0QHISXmTwX0
 UIfM1ruawjHM1OLDVV66JbExfL0DNiQSnaITrUCp5NqW+IuA05DGXjIjSPSUiMleY9PlOy/65RmT
 Rr4ei8OATlfri1sIm2TE4+eOrLPislxELZ/g1BglKBRvaJQd7xr74O4hBSz/kkmPgL+fgIguDmiQ
 iLrHPBwZStlwK9Qctw7OLmyubbvqIytQWIC1S+KOOj1Jcto7+pOU/BQuyJBzjt5fkffMOpXRwnoJ
 Yo591MNH89VcUVG/rHffeuRCUcMRFZ4oobg8BBg3Jq+ntzj07hLgnebh+IgqOGSsQlliML7mmfvv
 H8AAJ10/M6mmfXi3REW5XOZTEp8Dyz7eS3cSxMmnhan7ld5Btj8YCzmgH1FfEoXm0/FPF8PR0w36
 3lkeywGwPwXGvAKiJ5L9oQVFvqNfQiza3x4QvdmobTpnOiGSptvtgY8/SMqO9OohIts7jnxJ2JWr
 eVnk3yKNG42yi8l2R9lD/HojO/FRiY6gTWKrLjRFuOfsv9pIlKVsvXMUU4onvk6Td4Wqgmy49Btn
 G0XDK9jy+ML0pcfvwpalZQ==
X-Report-Abuse-To: spam@antispammaster.host-h.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Verify that bus sockets are present" example was not properly
formatted due to a typo in the literal block marker.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 Documentation/usb/usbmon.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/usb/usbmon.rst b/Documentation/usb/usbmon.rst
index b0bd51080..6d5ec1e62 100644
--- a/Documentation/usb/usbmon.rst
+++ b/Documentation/usb/usbmon.rst
@@ -42,7 +42,7 @@ if usbmon is built into the kernel::
 	# modprobe usbmon
 	#
 
-Verify that bus sockets are present:
+Verify that bus sockets are present::
 
 	# ls /sys/kernel/debug/usb/usbmon
 	0s  0u  1s  1t  1u  2s  2t  2u  3s  3t  3u  4s  4t  4u
-- 
2.30.2

