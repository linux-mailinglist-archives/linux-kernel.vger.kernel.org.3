Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433834B77E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbiBOTMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:12:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbiBOTMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:12:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD7D7D000;
        Tue, 15 Feb 2022 11:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644952291;
        bh=kAQ6lwfyj2i4+N1lB/jVhwxX2nyQTz+svM4N1tcB+H8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EY3Xe6mcT0Ejt06PJWtNeyGn2Gl/Ho/Qa+hG/Kyu7iLBhKRh3a6l75Dmpbc+lRoK2
         36U6mUp1lkoG8LK/qsh4NbDyQ7Lecxtrvf2FJNvJNI1DhO6gXo0IRG7J7nxziB6p2R
         JOH5kNjIyYgDOktDwfwHmO5bca1KpjxAqyoEvtRI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MEm2D-1nUAFE16HD-00GGOc; Tue, 15 Feb 2022 20:11:31 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] hwmon: (dell-smm) Add SMM interface documentation
Date:   Tue, 15 Feb 2022 20:11:12 +0100
Message-Id: <20220215191113.16640-7-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215191113.16640-1-W_Armin@gmx.de>
References: <20220215191113.16640-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yJeEw+Ln0SNeALbKihoWY6i0MarbQ3iVT3TvWe+xWJ6NkMmDj6S
 xQCQYZBqOA361qpf5xoFeyGWp88QHeAHLB2BQRQdnGHbL5VQpX56pNewzpBl4CeUBej3s8W
 0ceg0kaUOrKGAZx+77pH58Q4hY+K403+ZDWYcW1VV/ockd1xPlAJSUibhZG+nOQzVt+xATV
 /rmwLtHx/IEUoAOLM2l0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cZ8cXKKfEEk=:3o1JvlEtXK/zr2pyI8y05n
 VeT2y7Wm2kNj/NlnmoCOeniND819Q5ThQuNi4hDI7rSYltmN3OP4Zvls5w6Z4CKVwu6IUmMga
 7Wp+tGTIs8TX36EzasQq3uJf7hT8COeuambdL9JaoctTTXcKgrS1dFTxM9dYmwkQ7IeXwZOuf
 PE//b4aqpofllMXywLhOtaGk8BIWPouUiwEuzGZaxY2vfx+dksWTBSAngmvJ2lBQ3r28dJ1uf
 4h9Khaht1l1gypMfqEHOWNWbHARv0ZHqSklhoPBXuEXVDNk/Rk0QdWL4gDc/MuefCcPY1VMOa
 IaKripegpW2Ng6PuzkEh+E3LAyzt6zmB8vRDmvL8+VCkGeiD+/gNEcLN79PMvuHb8jRHrly74
 SF4a6BXirfnQARHTZ8LHCruHBNuOfZ8mNrJKV/QpYKb26Pm79lNBJlk6iR3273WDNXNlpZqvQ
 0LFXQQus5JXJn9g5N/sLQq2ZyEz4YjkFFpk6tb5Hg69HBJzDRYIv/loYSM3ar2k3UabacEBBD
 gwSIL1Q8Pr++Dv5rDfEo+Oegmsp05UsbSVtnJ441vYDTvg6/DdmsNUAsqy7OumaAk0DbBiYLb
 nCKRSR9yzKnpwTYmH7i4L9uBDAtu+qhaXGC5jtosluOAl33naK2/ZNGV3PLUQ7H0471AYWsIU
 KK1KNSxoZ95afxcVkDGbD7BZgii3vZBAEizpr85ZTIDOhpwTjVhF7xuEcl4SDQNT93KzJxrMi
 BBdg0wmilGecZsblnHvPu80F+Gf4O6f7LKRV/ZAjUBZFNqzysqYUd+l1tBA7hSkqx2ymhFuZc
 MBLUBuFhkg4qNlXv1qDWByESmIjrv2KcFeiJJfITMTRh4C1Ez6XXn3sET92z1Y/4kG90UBOKJ
 QzSwvf7wuqGk8pAlq1yRL4dqFlxJ/HwrmwaFpPitDTEMnoCj6ciUIBBn49T8xDUEMaLieaZEK
 FnbFbEClSU8erGuRJTLPWW60FomXmwXMTK+yXGjAJU2DCz5S185b/qPhaHA8X/ASKJnt1wrNp
 NdrT+dFPV80yZOLoqCEbABYYVFGxL2j43tq/b8U+d5RoayiADpaeeVLhl5DcbhCQgp0vHROZL
 K86G5l/jZWNBcE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SMM interface as requested by Pali Rohar.
Since Dell does not offer any offical documentation
regarding the SMM interface, the necessary information
was extracted from the dell_smm_hwmon driver and other
sources.

Suggested-by: Pali Roh=C3=A1r <pali@kernel.org>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst | 180 +++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index cfaee682a245..12bba5fd1447 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -173,3 +173,183 @@ obtain the same information and to control the fan s=
tatus. The ioctl
 interface can be accessed from C programs or from shell using the
 i8kctl utility. See the source file of ``i8kutils`` for more
 information on how to use the ioctl interface.
+
+SMM Interface
+-------------
+
+.. warning:: The SMM interface was reverse-engineered by trial-and-error
+             since Dell did not provide any Documentation,
+             please keep that in mind.
+
+The driver uses the SMM interface to send commands to the system BIOS.
+This interface is normally used by Dell's 32-bit diagnostic program or
+on newer notebook models by the buildin BIOS diagnostics.
+The SMM is triggered by writing to the special ioports ``0xb2`` and ``0x8=
4``,
+and may cause short hangs when the BIOS code is taking too long to
+execute.
+
+The SMM handler inside the system BIOS looks at the contents of the
+``eax``, ``ebx``, ``ecx``, ``edx``, ``esi`` and ``edi`` registers.
+Each register has a special purpose:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+Register        Purpose
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+eax             Holds the command code before SMM,
+                holds the first result after SMM.
+ebx             Holds the arguments.
+ecx             Unknown, set to 0.
+edx             Holds the second result after SMM.
+esi             Unknown, set to 0.
+edi             Unknown, set to 0.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+The SMM handler can signal a failure by either:
+
+- setting the lower sixteen bits of ``eax`` to ``0xffff``
+- not modifying ``eax`` at all
+- setting the carry flag
+
+SMM command codes
+-----------------
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Command Code    Command Name            Description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+``0x0025``      Get Fn key status       Returns the Fn key pressed after =
SMM:
+
+                                        - 9th bit in ``eax`` indicates Vo=
lume up
+                                        - 10th bit in ``eax`` indicates V=
olume down
+                                        - both bits indicate Volume mute
+
+``0xa069``      Get power status        Returns current power status afte=
r SMM:
+
+                                        - 1st bit in ``eax`` indicates Ba=
ttery connected
+                                        - 3th bit in ``eax`` indicates AC=
 connected
+
+``0x00a3``      Get fan state           Returns current fan state after S=
MM:
+
+                                        - 1st byte in ``eax`` holds the c=
urrent
+                                          fan state (0 - 2 or 3)
+
+``0x01a3``      Set fan state           Sets the fan speed:
+
+                                        - 1st byte in ``ebx`` holds the f=
an number
+                                        - 2nd byte in ``ebx`` holds the d=
esired
+                                          fan state (0 - 2 or 3)
+
+``0x02a3``      Get fan speed           Returns the current fan speed in =
RPM:
+
+                                        - 1st byte in ``ebx`` holds the f=
an number
+                                        - 1st word in ``eax`` holds the c=
urrent
+                                          fan speed in RPM (after SMM)
+
+``0x03a3``      Get fan type            Returns the fan type:
+
+                                        - 1st byte in ``ebx`` holds the f=
an number
+                                        - 1st byte in ``eax`` holds the
+                                          fan type (after SMM):
+
+                                          - 5th bit indicates docking fan
+                                          - 1 indicates Processor fan
+                                          - 2 indicates Motherboard fan
+                                          - 3 indicates Video fan
+                                          - 4 indicates Power supply fan
+                                          - 5 indicates Chipset fan
+                                          - 6 indicates other fan type
+
+``0x04a3``      Get nominal fan speed   Returns the nominal RPM in each f=
an state:
+
+                                        - 1st byte in ``ebx`` holds the f=
an number
+                                        - 2nd byte in ``ebx`` holds the f=
an state
+                                          in question (0 - 2 or 3)
+                                        - 1st word in ``eax`` holds the n=
ominal
+                                          fan speed in RPM (after SMM)
+
+``0x05a3``      Get fan speed tolerance Returns the speed tolerance for e=
ach fan state:
+
+                                        - 1st byte in ``ebx`` holds the f=
an number
+                                        - 2nd byte in ``ebx`` holds the f=
an state
+                                          in question (0 - 2 or 3)
+                                        - 1st byte in ``eax`` returns the=
 speed
+                                          tolerance
+
+``0x10a3``      Get sensor temperature  Returns the measured temperature:
+
+                                        - 1st byte in ``ebx`` holds the s=
ensor number
+                                        - 1st byte in ``eax`` holds the m=
easured
+                                          temperature (after SMM)
+
+``0x11a3``      Get sensor type         Returns the sensor type:
+
+                                        - 1st byte in ``ebx`` holds the s=
ensor number
+                                        - 1st byte in ``eax`` holds the
+                                          temperature type (after SMM):
+
+                                          - 1 indicates CPU sensor
+                                          - 2 indicates GPU sensor
+                                          - 3 indicates SODIMM sensor
+                                          - 4 indicates other sensor type
+                                          - 5 indicates Ambient sensor
+                                          - 6 indicates other sensor type
+
+``0xfea3``      Get SMM signature       Returns Dell signature if interfa=
ce
+                                        is supported (after SMM):
+
+                                        - ``eax`` holds 1145651527
+                                          (0x44494147 or "DIAG")
+                                        - ``edx`` holds 1145392204
+                                          (0x44454c4c or "DELL")
+
+``0xffa3``      Get SMM signature       Same as ``0xfea3``, check both.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+There are additional commands for enabling (``0x31a3`` or ``0x35a3``) and
+disabling (``0x30a3`` or ``0x34a3``) automatic fan speed control.
+The commands are however causing severe sideeffects on many machines, so
+they are not used by default.
+
+On several machines (Inspiron 3505, Precision 490, Vostro 1720, ...), the
+fans supports a 4th "magic" state, which signals the BIOS that automatic
+fan control should be enabled for a specific fan.
+However there are also some machines who do support a 4th regular fan sta=
te too,
+but in case of the "magic" state, the nominal RPM reported for this state=
 is a
+placeholder value, which however is not always detectable.
+
+Firmware Bugs
+-------------
+
+The SMM calls can behave erratic on some machines:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Firmware Bug                                            Affected Machines
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Reading of fan states return spurious errors.           Precision 490
+
+Reading of fan types causes erratic fan behaviour.      Studio XPS 8000
+
+                                                        Studio XPS 8100
+
+                                                        Inspiron 580
+
+Fan-related SMM calls take too long (about 500ms).      Inspiron 7720
+
+                                                        Vostro 3360
+
+                                                        XPS 13 9333
+
+                                                        XPS 15 L502X
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+In case you experience similar issues on your Dell machine, please
+submit a bugreport on bugzilla to we can apply workarounds.
+
+Limitations
+-----------
+
+The SMM calls can take too long to execute on some machines, causing
+short hangs and/or audio glitches.
+Also the fan state needs to be restored after suspend, as well as
+the automatic mode settings.
+When reading a temperature sensor, values above 127 degrees indicate
+a BIOS read error or a deactivated sensor.
=2D-
2.30.2

