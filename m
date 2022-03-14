Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13A14D8AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbiCNRTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiCNRTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:19:18 -0400
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Mar 2022 10:18:07 PDT
Received: from hl1100.dinaserver.com (hl1100.dinaserver.com [82.98.168.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B57F1B79E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:18:06 -0700 (PDT)
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_DBL_SPAM autolearn=no
        autolearn_force=no version=3.4.6
X-DinaScanner-From: info@foescoa.es
X-DinaScanner-SpamScore:  2.99
X-DinaScanner-SpamCheck: no es spam, SpamAssassin (almacenado, puntaje=2.992,
        requerido 6, autolearn=disabled, ALL_TRUSTED -1.00, BAYES_60 2.20,
        DKIMWL_BLOCKED 0.00, DKIM_SIGNED 0.10, DKIM_VALID -0.10,
        DKIM_VALID_AU -0.10, DKIM_VALID_EF -0.10, FROM_FMBLA_NDBLOCKED 0.00,
        FROM_IS_REPLY_TO -0.50, T_SCC_BODY_TEXT_LINE -0.01,
        URIBL_DBL_SPAM 2.50)
X-DinaScanner: Libre de Virus
X-DinaScanner-ID: B347A46C515B.A1AF9
X-DinaScanner-Information: DinaScanner. Filtro anti-Spam y anti-Virus
Received: from DESKTOP4PGD8QHHome (unknown [91.116.0.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: info@foescoa.es)
        by hl1100.dinaserver.com (Postfix) with ESMTPSA id B347A46C515B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:11:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=foescoa.es; s=default;
        t=1647277869; bh=osP0bnjNiRoJrOBrEdr9YZ5k1NUaAIb3chPo87sUgB8=;
        h=From:Reply-To:To:Subject:Date;
        b=ov8GcWdzjtpLqIkTXoM83YaYx/c+RijnhZfVkAfNVcsm6e3WphKmQntBATw7gdxxo
         Jm+yDg7MOryp8jTzdF1muoH1cyQehSFpDanTv10yf2hBjVJJM/nSjrM5/CWMxXzczt
         iTfYDYebNBOYRrlmayUf9KMgX2auOeOsbVJLiw6Y=
MIME-Version: 1.0
From:   info@foescoa.es
Reply-To: info@foescoa.es
To:     linux-kernel@vger.kernel.org
Subject: Marzo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 14 Mar 2022 18:11:10 +0100
Message-ID: <7888478468920244928350@DESKTOP-4PGD8QH>
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: foesco.com]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buenos d=EDas



Soy Alex Pons, director de FOESCO.


Os adjuntamos el listado de CURSOS BONIFICABLES para empleados en activo o =
ERTE disponibles para la presente convocatoria y la FICHA DE INSCRIPCI=D3N =
para solicitarlos.

=BFPod=E9is por favor confirmarnos que os han llegado correctamente los PDF=
 adjuntos=3F


Recordamos que todos los cursos impartidos son 100% Bonificables (Coste 0) =
con cargo al Cr=E9dito de Formaci=F3n 2022 disponible de cada empresa.

Si desconoc=E9is este dato nos lo pod=E9is consultar.



INSTRUCCIONES PARA SOLICITAR LOS CURSOS BONIFICABLES:

Se han de cumplimentar =FAnicamente los siguientes datos de la FICHA DE INS=
CRIPCI=D3N adjunta (1 impreso por curso) y se ha de mandar escaneado o en f=
otograf=EDa a esta misma direcci=F3n de correo electr=F3nico.

-  Curso a realizar
-  Nombre completo y DNI del alumno
-  N=FAmero de afiliaci=F3n a la Seguridad Social del alumno (Dato indicado=
 en las n=F3minas)
-  Tel=E9fono y e-mail del alumno
-  Nombre y CIF de la empresa
-  Direcci=F3n de la empresa
-  Tel=E9fono y e-mail de la empresa
-  Tel=E9fono y e-mail del gestor de la empresa
-  Cta. Cotizaci=F3n a la seguridad social de la empresa (Dato indicado en =
las n=F3minas)
-  A=F1o de creaci=F3n de la empresa
-  Nombre completo y DNI de un representante legal de la empresa
-  Firma del representante legal de la empresa.
-  Sello de la empresa.
-  Firma del alumno.



Quedamos a vuestra disposici=F3n.


Un cordial saludo.


Alex Pons
Director FOESCO


FOESCO Formaci=F3n Estatal Continua.
Empresa inscrita en el Registro de empresas de Formaci=F3n.

www.foesco.com
Tel:          910 323 794
(Horario de 9h a 15h y de 17h a 20h de lunes a Viernes)

FOESCO ofrece formaci=F3n a empresas y trabajadores en activo a trav=E9s de=
 cursos bonificados por la Fundaci=F3n Estatal para la Formaci=F3n en el Em=
pleo (antiguo FORCEM) que gestiona las acciones formativas de FORMACI=D3N C=
ONTINUA para trabajadores y se rige por la ley 30/2015 de 9 de septiembre.

Antes de imprimir este e-mail piense bien si es necesario hacerlo. La infor=
maci=F3n transmitida en este mensaje est=E1 dirigida solamente a las person=
as o entidades que figuran en el encabezamiento y contiene informaci=F3n co=
nfidencial, por lo que, si usted lo recibiera por error, por favor destr=FA=
yalo sin copiarlo, usarlo ni distribuirlo, comunic=E1ndolo inmediatamente a=
l emisor del mensaje. De conformidad con lo dispuesto en el Reglamento Euro=
peo del 2016/679, del 27 de abril de 2016, FOESCO le informa que los datos =
por usted suministrados ser=E1n tratados con las medidas de seguridad confo=
rmes a la normativa vigente que se requiere. Dichos datos ser=E1n empleados=
 con fines de gesti=F3n. Para el ejercicio de sus derechos de transparencia=
, informaci=F3n, acceso, rectificaci=F3n, supresi=F3n o derecho al olvido, =
limitaci=F3n del tratamiento, portabilidad de datos y oposici=F3n de sus da=
tos de car=E1cter personal deber=E1 dirigirse a la direcci=F3n del responsa=
ble del tratamiento a C/ LAGUNA DEL MARQUESADO N=BA10, 28021, MADRID, "PULS=
ANDO AQUI" <mailto:bajas@foesco.com=3FSubject=3DBAJA%20CORREOS> y "ENVIAR".
